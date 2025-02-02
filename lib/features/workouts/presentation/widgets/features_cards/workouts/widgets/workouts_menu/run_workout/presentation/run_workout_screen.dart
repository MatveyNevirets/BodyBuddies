import 'dart:async';

import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/bloc/run_workout_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/run_exercise_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/workout_ticker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return bloc;
      },
      child: Scaffold(
        body: BlocBuilder<RunWorkoutBloc, RunWorkoutState>(
            builder: (context, state) {
          if (state is WorkoutInProcess) {
            return RunExerciseScreen(
                state.exercises[state.currentExercise], ticker, state.duration);
          } else if (state is RestWorkoutProcess) {
            return RestScreen(ticker, state.duration);
          }
          return const CircularProgressIndicator();
        }),
      ),
    );
  }
}

String getTime(int duration) {
  String minutesToStr =
      ((duration / 60) % 60).floor().toString().padLeft(2, "0");
  String secondsToStr = (duration % 60).floor().toString().padLeft(2, "0");
  return "$minutesToStr:$secondsToStr";
}
