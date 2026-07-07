import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/workout_create_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/themes/colors.dart';

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
          color: Theme.of(context).scaffoldBackgroundColor,
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
                      style: DarkTheme.mini_journal_card_text,
                    ),
                    Text(
                      "Длительность:",
                      style: DarkTheme.mini_journal_card_text,
                    ),
                    Text(
                      workout.duration.isNotEmpty
                          ? workout.duration.toString()
                          : "00:00:00",
                      style: DarkTheme.mini_journal_card_text,
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      workout.date,
                      style: DarkTheme.mini_journal_card_text,
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
