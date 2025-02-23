import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/workouts/create_workout/presentation/workout_create_screen.dart';
import 'package:body_buddies/features/workouts/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors/colors.dart';

class JournalWorkoutCardItem extends StatelessWidget {
  WorkoutEntity workout;
  final VoidCallback removeItem;

  JournalWorkoutCardItem(this.workout, {super.key, required this.removeItem});

  @override
  Widget build(BuildContext context) {
    void openCurrentWorkout() {
      Navigator.of(context)
          .pushNamed("workouts_menu/current_workout/", arguments: [workout, 1]);
    }

    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () => openCurrentWorkout(),
        child: Card(
          color: Colours.workoutCardForegroundColor,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      truncateText(workout.title.toString(), 14),
                      style: Styles.mini_journal_card_text,
                    ),
                    Text(
                      "Длительность:",
                      style: Styles.mini_journal_card_text,
                    ),
                    Text(
                      workout.allWorkoutLength.isNotEmpty
                          ? workout.allWorkoutLength.toString()
                          : "00:00:00",
                      style: Styles.mini_journal_card_text,
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      workout.dateWhenTodo,
                      style: Styles.mini_journal_card_text,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => removeItem.call(),
                      child: const Icon(
                        Icons.delete,
                        color: Colours.workout_card_background_color,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
