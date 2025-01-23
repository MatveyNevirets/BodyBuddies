import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workout_button_widget.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/new_workout_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../core/strings/strings.dart';

class WorkoutCardOnList extends StatelessWidget {
  WorkoutEntity workout;
  List<ExerciseEntity> exercises;

  WorkoutCardOnList({required this.workout, required this.exercises});

  @override
  Widget build(BuildContext context) {
    openWorkout() {
      Navigator.of(context)
          .pushNamed("workouts_menu/current_workout/", arguments: exercises);
    }

    return GestureDetector(
      onTap: () => openWorkout(),
      child: Card(
        color: Colours.workout_card_background_color,
        child: Container(
          padding: EdgeInsets.only(
              right: Styles.base_margin_size_double,
              top: Styles.base_margin_size_double / 2,
              bottom: Styles.base_margin_size_double / 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  "lib/assets/images/workout_image.png",
                ),
                height: MediaQuery.sizeOf(context).height / 7,
                width: MediaQuery.sizeOf(context).height / 7,
              ),
              Expanded(child: SizedBox()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Styles.base_margin_size_double / 1.5,
                            vertical: Styles.base_margin_size_double / 10),
                        child: Text(
                          getDayOfWeekOnString(),
                          style: Styles.workout_text_style_week_day,
                        ),
                        decoration: BoxDecoration(
                            color: Colours.workout_card_foreground_color,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        truncateText(workout.title!, 10),
                        style: Styles.workout_text_style,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        truncateText(getMusclesGroupOnString(), 20),
                        style: Styles.workout_text_style2,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      NewWorkoutButton(
                          () {},
                          Size(MediaQuery.sizeOf(context).width / 5,
                              MediaQuery.sizeOf(context).width / 10)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getMusclesGroupOnString() {
    List<String> groups = [];

    if (workout.abs) groups.add("${Strings.abs}");
    if (workout.forearms) groups.add("${Strings.forearms}");
    if (workout.biceps) groups.add("${Strings.biceps}");
    if (workout.back) groups.add("${Strings.back}");
    if (workout.chest) groups.add("${Strings.chest}");
    if (workout.triceps) groups.add("${Strings.triceps}");
    if (workout.shoulders) groups.add("${Strings.shoulders}");
    if (workout.cardio) groups.add("${Strings.cardio}");
    if (workout.legs) groups.add("${Strings.legs}");

    return groups.toString().substring(1, groups.toString().length - 1);
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + '...';
    }
  }

  String getDayOfWeekOnString() {
    if (workout.weekday==1) {
      return Strings.mon;
    } else if (workout.weekday==2) {
      return Strings.tue;
    } else if (workout.weekday==3) {
      return Strings.wed;
    } else if (workout.weekday==4) {
      return Strings.thur;
    } else if (workout.weekday==5) {
      return Strings.fri;
    } else if (workout.weekday==6) {
      return Strings.sat;
    } else if (workout.weekday==7) {
      return Strings.sun;
    } else {
      return Strings.empty;
    }
  }
}
