import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/home/presentation/widgets/body_home_data.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/presentation/run_workout_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_create_entity/presentation/workout_create_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/material.dart';

class WorkoutEntityScreen extends StatelessWidget {
  const WorkoutEntityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List getPreviousScreenData =
        ModalRoute.of(context)!.settings.arguments as List;

    WorkoutEntity workoutEntity = getPreviousScreenData[0] as WorkoutEntity;
    int whatsOpen = getPreviousScreenData[1] as int;

    return Scaffold(
      appBar: createAppBarWidget(
          appbarTitle:
              whatsOpen == 0 ? Strings.workouts_appbar : Strings.journal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colours.workout_card_background_color,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  children: [
                    Card(
                      color: Colours.workoutCardForegroundColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 32),
                        child: Text(
                          textAlign: TextAlign.center,
                          workoutEntity.title.toString(),
                          style: Styles.workout_text_style_background_24,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: workoutEntity.exercises.length,
                      itemBuilder: (context, index) {
                        if (workoutEntity.exercises[index].isExercise) {
                          return Card(
                            color: Colours.workoutCardForegroundColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    truncateText(
                                        workoutEntity.exercises[index].title,
                                        20),
                                    style: Styles.mini_hint_background,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  buildRepsSetsFields(workoutEntity, index),
                                  buildRestWeightFields(workoutEntity, index),
                                ],
                              ),
                            ),
                          );
                        } else if (workoutEntity
                            .exercises[index].isTimerExercise) {
                          return Card(
                            color: Colours.workoutCardForegroundColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          truncateText(
                                              workoutEntity
                                                  .exercises[index].title,
                                              20),
                                          style: Styles.mini_hint_background,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        buildExerciseTimeSets(
                                            workoutEntity, index),
                                        buildWeightRestTime(
                                            workoutEntity, index),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return const CircularProgressIndicator();
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildExerciseTimeSets(WorkoutEntity workoutEntity, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            elevation: 3,
            color: Colours.workout_card_background_color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    Strings.time,
                    style: Styles.mini_current_card_text2,
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colours.workoutCardForegroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 8),
                      child: Text(
                        getTime(
                            workoutEntity.exercises[index].timerTimeMinutes *
                                    60 +
                                workoutEntity.exercises[index].timerTimeSeconds,
                            needHourses: false),
                        style: Styles.mini_current_card_text,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 3,
            color: Colours.workout_card_background_color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    Strings.sets,
                    style: Styles.mini_current_card_text2,
                  ),
                  const Expanded(child: SizedBox()),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colours.workoutCardForegroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 8),
                      child: Text(
                        workoutEntity.exercises[index].sets.toString(),
                        style: Styles.mini_current_card_text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildWeightRestTime(WorkoutEntity workoutEntity, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Card(
            elevation: 3,
            color: Colours.workout_card_background_color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    Strings.weight,
                    style: Styles.mini_current_card_text2,
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colours.workoutCardForegroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 8),
                      child: Text(
                        workoutEntity.exercises[index].kilograms ==
                                workoutEntity.exercises[index].kilograms.toInt()
                            ? workoutEntity.exercises[index].kilograms
                                .toInt()
                                .toString()
                            : workoutEntity.exercises[index].kilograms
                                .toString(),
                        style: Styles.mini_current_card_text,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Card(
            elevation: 3,
            color: Colours.workout_card_background_color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    Strings.rest,
                    style: Styles.mini_current_card_text2,
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colours.workoutCardForegroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 8),
                      child: Text(
                        getTime(
                            workoutEntity.exercises[index].restTimeInMinutes *
                                    60 +
                                workoutEntity
                                    .exercises[index].restTimeInSeconds,
                            needHourses: false),
                        style: Styles.mini_current_card_text,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRestWeightFields(WorkoutEntity workoutEntity, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Card(
            elevation: 3,
            color: Colours.workout_card_background_color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    Strings.rest,
                    style: Styles.mini_current_card_text2,
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colours.workoutCardForegroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 8),
                      child: Text(
                        getTime(
                            workoutEntity.exercises[index].restTimeInMinutes *
                                    60 +
                                workoutEntity
                                    .exercises[index].restTimeInSeconds,
                            needHourses: false),
                        style: Styles.mini_current_card_text,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Card(
            elevation: 3,
            color: Colours.workout_card_background_color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    Strings.weight,
                    style: Styles.mini_current_card_text2,
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colours.workoutCardForegroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 8),
                      child: Text(
                        workoutEntity.exercises[index].kilograms ==
                                workoutEntity.exercises[index].kilograms.toInt()
                            ? workoutEntity.exercises[index].kilograms
                                .toInt()
                                .toString()
                            : workoutEntity.exercises[index].kilograms
                                .toString(),
                        style: Styles.mini_current_card_text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRepsSetsFields(WorkoutEntity workoutEntity, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            elevation: 3,
            color: Colours.workout_card_background_color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    Strings.repeats,
                    style: Styles.mini_current_card_text2,
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colours.workoutCardForegroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 8),
                      child: Text(
                        workoutEntity.exercises[index].reps.toString(),
                        style: Styles.mini_current_card_text,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 3,
            color: Colours.workout_card_background_color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    Strings.sets,
                    style: Styles.mini_current_card_text2,
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colours.workoutCardForegroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 8),
                      child: Text(
                        workoutEntity.exercises[index].sets.toString(),
                        style: Styles.mini_current_card_text,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
