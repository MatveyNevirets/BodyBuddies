import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/workouts/run_workout/bloc/run_workout_bloc.dart';
import 'package:body_buddies/features/workouts/run_workout/presentation/run_workout_screen.dart';
import 'package:body_buddies/features/workouts/run_workout/workout_ticker/reverse_ticker.dart';
import 'package:body_buddies/features/workouts/run_workout/workout_ticker/workout_ticker.dart';
import 'package:body_buddies/features/workouts/workouts_menu/domain/entity/exercise_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/strings/strings.dart';
import '../../../../core/widgets/base_button.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colours.workoutCardForegroundColor,
            child: Container(
              padding: const EdgeInsets.all(16),
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                children: [
                  buildWorkoutTimeWidget(context),
                  const SizedBox(
                    height: 16,
                  ),
                  buildRestTextWidget(context),
                  const SizedBox(
                    height: 32,
                  ),
                  buildSkipButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BaseButton buildSkipButton(BuildContext context) {
    return BaseButton(
      onClick: () => nextOnExercisesList(context),
      buttonText: Strings.skip,
      icon: null,
      isElevated: true,
      backgroundColor: Colours.workout_card_background_color,
      color: Colours.workoutCardForegroundColor,
      radius: 8,
      buttonSize: Size(MediaQuery.sizeOf(context).width,
          MediaQuery.sizeOf(context).height / 15),
    );
  }

  Padding buildWorkoutTimeWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            Strings.timeOfWorkout,
            style: Styles.reverse_rest_text_style,
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 55,
            width: MediaQuery.sizeOf(context).width / 2.5,
            child: Card(
              elevation: 3,
              color: Colours.workout_card_background_color,
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  child: StreamBuilder(
                      stream: ticker.workoutTick(workoutTimerDuration),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          workoutTimerDuration = snapshot.data!;
                          return Text(
                            getTime(workoutTimerDuration),
                            style: Styles.add_exercise_text_style,
                          );
                        } else if (snapshot.hasError) {
                          throw Exception(
                              "Run exercise Snapshot error: ${snapshot.error}");
                        }
                        return Text(
                          getTime(workoutTimerDuration),
                          style: Styles.add_exercise_text_style,
                        );
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildRestTextWidget(BuildContext context) {
    int duration = exercise.restTimeInMinutes * 60 + exercise.restTimeInSeconds;
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 1,
      height: MediaQuery.sizeOf(context).height / 5,
      child: Card(
        color: Colours.workout_card_background_color,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                Strings.rest,
                style: Styles.workout_text_style,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 100,
              ),
              SizedBox(
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
                              "${exercise.restTimeInMinutes.toString().padLeft(2, "0")}:${exercise.restTimeInSeconds.toString().padLeft(2, "0")}",
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

  void nextOnExercisesList(BuildContext context) {
    context.read<RunWorkoutBloc>().add(ExerciseRunEvent(workoutTimerDuration));
  }
}
