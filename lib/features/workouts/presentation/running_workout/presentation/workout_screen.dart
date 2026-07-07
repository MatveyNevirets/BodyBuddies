import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/presentation/bloc/running_workout_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/presentation/exercise_screen.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/presentation/timer_exercise_screen.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/workout_ticker/workout_ticker.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';

import '../../../../../core/strings/strings.dart';
import 'rest_screen.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WorkoutEntity workout =
        ModalRoute.of(context)!.settings.arguments as WorkoutEntity;

    WorkoutTicker ticker = WorkoutTicker();

    WorkoutEntity workoutToJournal =
        WorkoutEntity(title: workout.title, exercises: []);

    final depends = AppDependsProvider.of(context);

    return BlocProvider(
      create: (BuildContext blocContext) {
        final bloc = RunningWorkoutBloc(workout.exercises, 0,
            depends.workoutsRepository, depends.secureStorage);
        bloc.exercises[bloc.state.currentExercise].currentSets = 1;
        return bloc;
      },
      child: Scaffold(
        body: BlocConsumer<RunningWorkoutBloc, RunningWorkoutState>(
          listener: (context, state) {
            if (state is CompleteWorkout) {
              completeWorkout(context);
            }
          },
          builder: (context, state) {
            return BlocBuilder<RunningWorkoutBloc, RunningWorkoutState>(
                builder: (context, state) {
              if (state is WorkoutInProcess) {
                if (state.exercises[state.currentExercise].isExercise) {
                  return ExerciseScreen(state.exercises[state.currentExercise],
                      ticker, state.duration, state, workoutToJournal);
                } else if (state
                    .exercises[state.currentExercise].isTimerExercise) {
                  return TimerExerciseScreen(
                      state.exercises[state.currentExercise],
                      ticker,
                      state.duration,
                      state,
                      workoutToJournal);
                }
              } else if (state is RestWorkoutProcess) {
                return RestScreen(ticker, state.duration,
                    state.exercises[state.currentExercise]);
              }
              return const LoadingScreen();
            });
          },
        ),
      ),
    );
  }

  void completeWorkout(BuildContext context) {
    showSnackBar(context, Strings.completedSuccessful);
    Navigator.of(context).pop();
  }
}

String getTime(int duration, {bool needHourses = true}) {
  String hoursesToString =
      (((duration / 60) / 60) % 60).floor().toString().padLeft(2, "0");
  String minutesToString =
      ((duration / 60) % 60).floor().toString().padLeft(2, "0");
  String secondsToString = (duration % 60).floor().toString().padLeft(2, "0");
  return needHourses
      ? "$hoursesToString:$minutesToString:$secondsToString"
      : "$minutesToString:$secondsToString";
}
