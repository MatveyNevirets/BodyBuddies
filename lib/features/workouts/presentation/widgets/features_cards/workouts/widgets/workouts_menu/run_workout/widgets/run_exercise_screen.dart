import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/bloc/run_workout_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/presentation/run_workout_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/workout_ticker.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../core/widgets/base_button.dart';

class RunExerciseScreen extends StatelessWidget {
  ExerciseEntity exercise;
  WorkoutEntity journalWorkout;
  WorkoutTicker ticker;

  RunWorkoutState state;

  int workoutTimerDuration;

  RunExerciseScreen(this.exercise, this.ticker, this.workoutTimerDuration,
      this.state, this.journalWorkout,
      {super.key});

  var repsController = TextEditingController();
  var weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    repsController.text = exercise.reps.toString();
    weightController.text = exercise.kilograms.toString();

    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 32, top: 64),
      child: Card(
        color: Colours.workout_card_background_color,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            color: Colours.workoutCardForegroundColor,
            child: Container(
              padding: const EdgeInsets.all(16),
              height: double.maxFinite,
              width: double.maxFinite,
              child: Wrap(
                children: [
                  Column(
                    children: [
                      buildTimeAndSetsWidget(exercise, ticker),
                      const SizedBox(
                        height: 16,
                      ),
                      buildBodyWidgets(),
                      const SizedBox(
                        height: 16,
                      ),
                      BaseButton(
                          onClick: () => nextOnExercisesList(
                              context, workoutTimerDuration, journalWorkout),
                          buttonText: Strings.done,
                          icon: null,
                          isElevated: true),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card buildBodyWidgets() {
    return Card(
      color: Colours.workout_card_background_color,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          color: Colours.workoutCardForegroundColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: buildWorkoutTitleWidget(exercise.title),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: buildInputFieldsWidget(exercise),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimeAndSetsWidget(ExerciseEntity exercise, WorkoutTicker ticker) {
    return Row(
      children: [
        Card(
          color: Colours.workout_card_background_color,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  Strings.time,
                  style: Styles.add_exercise_text_style,
                ),
                Container(
                  height: 40,
                  width: 110,
                  child: Card(
                    elevation: 2,
                    color: Colours.workoutCardForegroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      child: StreamBuilder(
                          stream: ticker.workoutTick(workoutTimerDuration),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              workoutTimerDuration = snapshot.data!;
                              return Text(
                                getTime(workoutTimerDuration),
                                style: Styles.hint_text_style_create_workout,
                              );
                            } else if (snapshot.hasError) {
                              throw Exception(
                                  "Run exercise Snapshot error: ${snapshot.error}");
                            }
                            return Text(
                              getTime(workoutTimerDuration),
                              style: Styles.hint_text_style_create_workout,
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        Card(
          color: Colours.workout_card_background_color,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.sets,
                  style: Styles.add_exercise_text_style,
                ),
                Card(
                  color: Colours.workoutCardForegroundColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 32),
                    child: Text(
                      "${exercise.currentSets.toString()} | ${exercise.sets.toString()}",
                      style: Styles.hint_text_style_create_workout,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Card buildWorkoutTitleWidget(String title) {
    return Card(
      color: Colours.workout_card_background_color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Text(
              title,
              style: Styles.add_exercise_text_style,
            ),
          ],
        ),
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
          child: Row(
            children: [
              Expanded(
                child: Card(
                  color: Colours.workout_card_background_color,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Text(
                          Strings.weight,
                          style: Styles.add_exercise_text_style,
                        ),
                        Card(
                          color: Colours.workoutCardForegroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: TextField(
                              style: Styles.mini_hint_background,
                              textAlign: TextAlign.center,
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                    width: 0,
                                  )),
                                  hintText: exercise.kilograms.toString(),
                                  hintStyle: Styles.mini_hint_background),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text("Reps"),
                    TextField(
                      controller: repsController,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(hintText: exercise.reps.toString()),
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

  void nextOnExercisesList(
      BuildContext context, int duration, WorkoutEntity journalWorkout) {
    ExerciseEntity exerciseEntity = ExerciseEntity(
        title: exercise.title,
        sets: exercise.sets,
        reps: int.parse(repsController.text),
        kilograms: double.parse(weightController.text),
        isExercise: exercise.isExercise,
        isTimerExercise: exercise.isTimerExercise,
        restTimeInMinutes: exercise.restTimeInMinutes,
        restTimeInSeconds: exercise.restTimeInSeconds,
        timerTimeMinutes: exercise.timerTimeMinutes,
        timerTimeSeconds: exercise.timerTimeSeconds);

    journalWorkout.exercises.add(exerciseEntity);

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
