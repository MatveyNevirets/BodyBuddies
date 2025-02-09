import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/bloc/run_workout_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/presentation/run_workout_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/reverse_ticker.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/workout_ticker.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../core/widgets/base_button.dart';

class RestScreen extends StatelessWidget {
  ExerciseEntity exercise;

  WorkoutTicker ticker;
  ReverseTicker reverseTicker = ReverseTicker();
  int workoutTimerDuration;

  RestScreen(this.ticker, this.workoutTimerDuration, this.exercise,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 64),
      child: Card(
        color: Colours.workout_card_background_color,
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            children: [
              buildWorkoutTimeWidget(),
              const SizedBox(
                height: 16,
              ),
              buildRestTextWidget(),
              const SizedBox(
                height: 16,
              ),
              BaseButton(
                  onClick: () => nextOnExercisesList(context),
                  buttonText: Strings.skip,
                  icon: null,
                  isElevated: true),
            ],
          ),
        ),
      ),
    );
  }

  Container buildWorkoutTimeWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colours.workoutCardForegroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Время"),
          StreamBuilder(
              stream: ticker.workoutTick(workoutTimerDuration),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  workoutTimerDuration = snapshot.data!;
                  return Text(getTime(workoutTimerDuration));
                } else if (snapshot.hasError) {
                  throw Exception(
                      "Exception on RunRest Snapshot error: ${snapshot.error}");
                }
                return Text(getTime(workoutTimerDuration));
              })
        ],
      ),
    );
  }

  Container buildRestTextWidget() {
    int duration = exercise.restTimeInMinutes * 60 + exercise.restTimeInSeconds;

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colours.workoutCardForegroundColor,
      child: Column(
        children: [
          const Text("Отдых"),
          StreamBuilder(
            stream: reverseTicker.reverseTick(duration),
            builder: (context, snapshot) {
  
              if (snapshot.hasData) {
                if (snapshot.data! > 0) {
                  return Text(getTime(snapshot.data!));
                } else {
                  nextOnExercisesList(context);
                }
              } else if (snapshot.hasError) {
                throw Exception(
                    "Snapshot reverse timer has error: ${snapshot.error}");
              }
              return Text(
                  "${exercise.restTimeInMinutes.toString().padLeft(2, "0")}:${exercise.restTimeInSeconds.toString().padLeft(2, "0")}");
            },
          ),
        ],
      ),
    );
  }

  void nextOnExercisesList(BuildContext context) {
    context.read<RunWorkoutBloc>().add(ExerciseRunEvent(workoutTimerDuration));
  }
}
