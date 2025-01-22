import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:flutter/material.dart';

class WorkoutEntityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ExerciseEntity> exercises =
        ModalRoute.of(context)!.settings.arguments as List<ExerciseEntity>;

    return Scaffold(
      body: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
               Text(exercises[index].title),
                  Text(exercises[index].kilograms.toString()),
                  Text(exercises[index].sets.toString()),
                  Text(exercises[index].reps.toString()),
              ],
            );
          }),
    );
  }
}
