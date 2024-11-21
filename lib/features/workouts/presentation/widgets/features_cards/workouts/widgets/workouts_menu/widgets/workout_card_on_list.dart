import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../core/strings/strings.dart';

class WorkoutCardOnList extends StatelessWidget {
  WorkoutEntity workout;
  List<ExerciseEntity> exercises;

  WorkoutCardOnList({required this.workout, required this.exercises});

  @override
  Widget build(BuildContext context) {

    openWorkout() {
      Navigator.of(context).pushNamed("workouts_menu/current_workout/", arguments: exercises);
    }

    return GestureDetector(
      onTap: () => openWorkout(),
      child: Card(
        child: Column(
          children: [
            Text(workout.title!),
            Text(getMusclesGroupOnString()),
            Text(getDayOfWeekOnString()),
            BaseButton(
                onClick: () {},
                buttonText: Strings.start,
                icon: null,
                isElevated: true)
          ],
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

  String getDayOfWeekOnString() {
    if (workout.mon) {
      return Strings.monday;
    } else if (workout.tue) {
      return Strings.tuesday;
    } else if (workout.wen) {
      return Strings.wednesday;
    } else if (workout.thur) {
      return Strings.thursday;
    } else if (workout.fri) {
      return Strings.friday;
    } else if (workout.sun) {
      return Strings.sunday;
    } else if (workout.sat) {
      return Strings.saturday;
    } else {
      return Strings.empty;
    }
  }
}
