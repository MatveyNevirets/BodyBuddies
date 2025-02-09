import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_card_on_list.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../core/colors/colors.dart';

class JournalWorkoutCardItem extends StatelessWidget {
  WorkoutEntity workout;

  JournalWorkoutCardItem(this.workout);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(workout.title.toString()),
                Text("Длительность:"),
                Text("00:00:00"),
              ],
            ),
            Expanded(child: SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("25.05.32"),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colours.workout_card_background_color,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
