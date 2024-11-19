import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../core/strings/strings.dart';

class WorkoutCardOnList extends StatelessWidget {
  WorkoutEntity workout;

  WorkoutCardOnList({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(workout.title!),
          Text(getMusclesGroupOnString()),
          Text("Понедельник"),
          BaseButton(
              onClick: () {},
              buttonText: Strings.start,
              icon: null,
              isElevated: true)
        ],
      ),
    );
  }

  String getMusclesGroupOnString() {
    List<String> groups = [Strings.abs];
    //TODO: СЮДА ОБРАБОТКА ДАННЫХ ПО УСЛОВНОМУ БЛОКУ И ДОБАВЛЕНИЕ В СПИСОК ПРИ TRUE
    return groups.first;
  }
}
