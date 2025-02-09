import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_create_entity/presentation/workout_create_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../core/colors/colors.dart';

class JournalWorkoutCardItem extends StatelessWidget {
  WorkoutEntity workout;
  final VoidCallback removeItem;

  JournalWorkoutCardItem(this.workout, {super.key, required this.removeItem});

  @override
  Widget build(BuildContext context) {
    void openCurrentWorkout() {
      Navigator.of(context)
          .pushNamed("workouts_menu/current_workout/", arguments: workout);
    }

    return GestureDetector(
      onTap: () => openCurrentWorkout(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(truncateText(workout.title.toString(), 16)),
                  const Text("Длительность:"),
                  Text(workout.allWorkoutLength.isNotEmpty
                      ? workout.allWorkoutLength.toString()
                      : "00:00:00"),
                ],
              ),
              const Expanded(child: SizedBox()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(workout.dateWhenTodo),
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
    );
  }
}
