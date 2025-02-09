import 'dart:async';

import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/bloc/run_workout_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/run_exercise_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/run_timer_exercise_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/reverse_ticker.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/workout_ticker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../core/strings/strings.dart';
import '../../widgets/workout_entities/entity/exercise_entity.dart';
import '../widgets/run_rest_screen.dart';

class RunWorkoutScreen extends StatelessWidget {
  const RunWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ExerciseEntity> exercises =
        ModalRoute.of(context)!.settings.arguments as List<ExerciseEntity>;

    WorkoutTicker ticker = WorkoutTicker();

    return BlocProvider(
      create: (BuildContext blocContext) {
        final bloc = RunWorkoutBloc(exercises, 0);
        bloc.exercises[bloc.state.currentExercise].currentSets = 1;
        return bloc;
      },
      child: Scaffold(
        body: BlocConsumer<RunWorkoutBloc, RunWorkoutState>(
          listener: (context, state) {
            if (state is CompleteWorkout) {
              completeWorkout(context);
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
                      state);
                } else if (state
                    .exercises[state.currentExercise].isTimerExercise) {
                  return RunTimerExercise(
                      state.exercises[state.currentExercise],
                      ticker,
                      state.duration,
                      state);
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

  void completeWorkout(BuildContext context) {
    showSnackBar(context, Strings.completedSuccessful);
    Navigator.of(context).pop();
  }
}

String getTime(int duration) {
  String minutesToStr =
      ((duration / 60) % 60).floor().toString().padLeft(2, "0");
  String secondsToStr = (duration % 60).floor().toString().padLeft(2, "0");
  return "$minutesToStr:$secondsToStr";
}
