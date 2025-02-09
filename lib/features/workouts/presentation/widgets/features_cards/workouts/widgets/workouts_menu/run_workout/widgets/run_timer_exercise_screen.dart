import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/reverse_ticker.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/workout_ticker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../core/widgets/base_button.dart';
import '../../widgets/workout_entities/entity/exercise_entity.dart';
import '../bloc/run_workout_bloc.dart';
import '../presentation/run_workout_screen.dart';

class RunTimerExercise extends StatelessWidget {
  ExerciseEntity exercise;
  WorkoutTicker ticker;
  ReverseTicker reverseTicker = ReverseTicker();

  RunWorkoutState state;

  int workoutTimerDuration;

  RunTimerExercise(
      this.exercise, this.ticker, this.workoutTimerDuration, this.state,
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
              buildTimeAndSetsWidget(exercise, ticker),
              const SizedBox(
                height: 16,
              ),
              buildWorkoutTitleWidget(exercise.title),
              const SizedBox(
                height: 16,
              ),
              buildExerciseTimerWidget(),
              const SizedBox(
                height: 16,
              ),
              buildInputFieldsWidget(exercise),
              const SizedBox(
                height: 16,
              ),
              BaseButton(
                  onClick: () => nextOnExercisesList(context),
                  buttonText: Strings.done,
                  icon: null,
                  isElevated: true),
            ],
          ),
        ),
      ),
    );
  }

  Container buildExerciseTimerWidget() {
    int duration = exercise.timerTimeMinutes * 60 + exercise.timerTimeSeconds;
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colours.workoutCardForegroundColor,
      child: Column(
        children: [
          Text(Strings.exercise),
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
                  "${exercise.timerTimeMinutes.toString().padLeft(2, "0")}:${exercise.timerTimeSeconds.toString().padLeft(2, "0")}");
            },
          ),
        ],
      ),
    );
  }

  Container buildTimeAndSetsWidget(
      ExerciseEntity exercise, WorkoutTicker ticker) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colours.workoutCardForegroundColor,
      child: Row(
        children: [
          StreamBuilder(
              stream: ticker.workoutTick(workoutTimerDuration),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  workoutTimerDuration = snapshot.data!;
                  return Text(getTime(workoutTimerDuration));
                } else if (snapshot.hasError) {
                  throw Exception(
                      "Run exercise Snapshot error: ${snapshot.error}");
                }
                return Text(getTime(workoutTimerDuration));
              }),
          const Expanded(child: SizedBox()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(Strings.sets),
              Text(
                  "${exercise.currentSets.toString()}/${exercise.sets.toString()}"),
            ],
          ),
        ],
      ),
    );
  }

  Container buildWorkoutTitleWidget(String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colours.workoutCardForegroundColor,
      child: Column(
        children: [
          Text(title),
        ],
      ),
    );
  }

  Wrap buildInputFieldsWidget(ExerciseEntity exercise) {
    return Wrap(
      children: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 250,
            maxHeight: 100,
          ),
          color: Colours.workoutCardForegroundColor,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text("Kg"),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: exercise.kilograms.toString()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void nextOnExercisesList(BuildContext context) {
    if (state.exercises.last == exercise &&
        state.exercises.last.currentSets == exercise.sets) {
      context
          .read<RunWorkoutBloc>()
          .add(WorkoutCompleteEvent(workoutTimerDuration));
    } else {
      context
          .read<RunWorkoutBloc>()
          .add(ExerciseRestEvent(workoutTimerDuration));
    }
  }
}
