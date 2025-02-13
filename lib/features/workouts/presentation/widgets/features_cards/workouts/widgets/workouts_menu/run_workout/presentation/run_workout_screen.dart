import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/bloc/run_workout_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/run_exercise_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/run_timer_exercise_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/workout_ticker.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../core/strings/strings.dart';
import '../widgets/run_rest_screen.dart';

class RunWorkoutScreen extends StatelessWidget {
  FakeWorkoutsDatabase fakeWorkoutsDatabase;

  RunWorkoutScreen({super.key, required this.fakeWorkoutsDatabase});

  @override
  Widget build(BuildContext context) {
    WorkoutEntity workout =
        ModalRoute.of(context)!.settings.arguments as WorkoutEntity;

    WorkoutTicker ticker = WorkoutTicker();

    WorkoutEntity workoutToJournal =
        WorkoutEntity(title: workout.title, exercises: []);

    return BlocProvider(
      create: (BuildContext blocContext) {
        final bloc = RunWorkoutBloc(workout.exercises, 0);
        bloc.exercises[bloc.state.currentExercise].currentSets = 1;
        return bloc;
      },
      child: Scaffold(
        body: BlocConsumer<RunWorkoutBloc, RunWorkoutState>(
          listener: (context, state) {
            if (state is CompleteWorkout) {
              completeWorkout(context, workoutToJournal, state.duration);
            }
          },
          builder: (context, state) {
            return BlocBuilder<RunWorkoutBloc, RunWorkoutState>(
                builder: (context, state) {
              if (state is WorkoutInProcess) {
                if (state.exercises[state.currentExercise].isExercise) {
                  return RunExerciseScreen(
                      state.exercises[state.currentExercise],
                      ticker,
                      state.duration,
                      state,
                      workoutToJournal);
                } else if (state
                    .exercises[state.currentExercise].isTimerExercise) {
                  return RunTimerExercise(
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
              return const CircularProgressIndicator();
            });
          },
        ),
      ),
    );
  }

  void completeWorkout(
      BuildContext context, WorkoutEntity workout, int duration) {
    WorkoutEntity newWorkoutEntity = WorkoutEntity(
        title: workout.title, exercises: List.from(workout.exercises));

    DateTime currentData = DateTime.now();
    String dataInFormat =
        "${currentData.day.toString().padLeft(2, "0")}.${currentData.month.toString().padLeft(2, "0")}.${currentData.year}";

    newWorkoutEntity.allWorkoutLength = getTime(duration);
    newWorkoutEntity.dateWhenTodo = dataInFormat;
    fakeWorkoutsDatabase.journalSavedWorkouts.add(newWorkoutEntity);
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
