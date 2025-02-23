import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/workouts/run_workout/bloc/run_workout_bloc.dart';
import 'package:body_buddies/features/workouts/run_workout/presentation/run_workout_screen.dart';
import 'package:body_buddies/features/workouts/run_workout/workout_ticker/workout_ticker.dart';
import 'package:body_buddies/features/workouts/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/strings/strings.dart';
import '../../../../core/widgets/base_button.dart';

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
                        height: 32,
                      ),
                      buildDoneButton(context),
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

  BaseButton buildDoneButton(BuildContext context) {
    return BaseButton(
      onClick: () =>
          nextOnExercisesList(context, workoutTimerDuration, journalWorkout),
      buttonText: Strings.done,
      icon: null,
      isElevated: true,
      backgroundColor: Colours.workout_card_background_color,
      color: Colours.workoutCardForegroundColor,
      radius: 8,
      buttonSize:
          Size(double.maxFinite, MediaQuery.sizeOf(context).height / 18),
    );
  }

  SizedBox buildBodyWidgets() {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
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
                SizedBox(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: buildInputFieldsWidget(exercise),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
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
                SizedBox(
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
        const Expanded(child: SizedBox()),
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
        Row(
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
                            onTapAlwaysCalled: true,
                            // ignore: avoid_print
                            onTap: () => print("tap"),
                            style: Styles.mini_hint_background,
                            textAlign: TextAlign.center,
                            cursorColor: Colours.workout_card_background_color,
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: exercise.kilograms ==
                                        exercise.kilograms.toInt()
                                    ? exercise.kilograms.toInt().toString()
                                    : exercise.kilograms.toString(),
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
              child: Card(
                color: Colours.workout_card_background_color,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      Text(
                        Strings.rep,
                        style: Styles.add_exercise_text_style,
                      ),
                      Card(
                        color: Colours.workoutCardForegroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: TextField(
                            style: Styles.mini_hint_background,
                            textAlign: TextAlign.center,
                            controller: repsController,
                            cursorColor: Colours.workout_card_background_color,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: exercise.reps.toString(),
                                hintStyle: Styles.mini_hint_background),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void nextOnExercisesList(
      BuildContext context, int duration, WorkoutEntity journalWorkout) {
    double weight;
    int reps;

    if (weightController.text.isEmpty) {
      weight = exercise.kilograms;
    } else {
      weight = double.parse(weightController.text);
    }

    if (repsController.text.isEmpty) {
      reps = exercise.reps;
    } else {
      reps = int.parse(repsController.text);
    }

    ExerciseEntity exerciseEntity = ExerciseEntity(
        title: exercise.title,
        sets: exercise.sets,
        reps: reps,
        kilograms: weight,
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
