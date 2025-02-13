import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/reverse_ticker.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/workout_ticker.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
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

  WorkoutEntity journalWorkout;
  TextEditingController weightController;

  RunWorkoutState state;

  int workoutTimerDuration;

  RunTimerExercise(this.exercise, this.ticker, this.workoutTimerDuration,
      this.state, this.journalWorkout,
      {super.key})
      : weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 32, top: 64),
      child: Card(
        color: Colours.workout_card_background_color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colours.workoutCardForegroundColor,
            elevation: 4,
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
                      Container(
                          width: double.maxFinite,
                          child: buildWorkoutTitleWidget(exercise.title)),
                      const SizedBox(
                        height: 16,
                      ),
                      buildExerciseTimerWidget(context),
                      const SizedBox(
                        height: 16,
                      ),
                      buildInputFieldsWidget(exercise),
                      const SizedBox(
                        height: 24,
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
      onClick: () => nextOnExercisesList(context),
      buttonText: Strings.done,
      icon: null,
      isElevated: true,
      backgroundColor: Colours.workout_card_background_color,
      color: Colours.workoutCardForegroundColor,
      radius: 8,
      buttonSize: Size(MediaQuery.sizeOf(context).width,
          MediaQuery.sizeOf(context).height / 15),
    );
  }

  Container buildExerciseTimerWidget(BuildContext context) {
    int duration = exercise.timerTimeMinutes * 60 + exercise.timerTimeSeconds;
    return Container(
      width: MediaQuery.sizeOf(context).width / 1,
      height: MediaQuery.sizeOf(context).height / 5,
      child: Card(
        color: Colours.workout_card_background_color,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                Strings.exercise,
                style: Styles.workout_text_style,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 100,
              ),
              Container(
                height: MediaQuery.sizeOf(context).height / 12,
                width: MediaQuery.sizeOf(context).width / 1.7,
                child: Card(
                  elevation: 2,
                  color: Colours.workoutCardForegroundColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    child: Center(
                      child: StreamBuilder(
                          stream: reverseTicker.reverseTick(duration),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data! > 0) {
                                return Text(
                                  getTime(snapshot.data!, needHourses: false),
                                  style:
                                      Styles.workout_text_style_background_24,
                                );
                              } else {
                                nextOnExercisesList(context);
                                return Text(
                                  getTime(0, needHourses: false),
                                  style:
                                      Styles.workout_text_style_background_24,
                                );
                              }
                            } else if (snapshot.hasError) {
                              throw Exception(
                                  "Run exercise Snapshot error: ${snapshot.error}");
                            }
                            return Text(
                              "${exercise.timerTimeMinutes.toString().padLeft(2, "0")}:${exercise.timerTimeSeconds.toString().padLeft(2, "0")}",
                              style: Styles.workout_text_style_background_24,
                            );
                          }),
                    ),
                  ),
                ),
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
    return Wrap(children: [
      Card(
        color: Colours.workout_card_background_color,
        child: Padding(
          padding: const EdgeInsets.all(8),
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
                    onTap: () => print("tap"),
                    style: Styles.mini_hint_background,
                    textAlign: TextAlign.center,
                    cursorColor: Colours.workout_card_background_color,
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText:
                            exercise.kilograms == exercise.kilograms.toInt()
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
    ]);
  }

  void nextOnExercisesList(BuildContext context) {
    double weight;

    if (weightController.text.isEmpty) {
      weight = exercise.kilograms;
    } else {
      weight = double.parse(weightController.text);
    }

    ExerciseEntity exerciseEntity = ExerciseEntity(
        title: exercise.title,
        sets: exercise.sets,
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
