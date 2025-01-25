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
            if (exercises[index].isExercise) {
              return Column(
                children: [
                  Text(exercises[index].title),
                  Text("kg: ${exercises[index].kilograms.toString()}"),
                  Text("sets: ${exercises[index].sets.toString()}"),
                  Text("reps: ${exercises[index].reps.toString()}"),
                  SizedBox(
                    height: 30,
                  ),
                ],
              );
            } else if (exercises[index].isRest) {
              return Column(
                children: [
                  Center(
                    child: Text(
                        "restTime: ${exercises[index].restTimeInMinutes.toString()}:${exercises[index].restTimeInSeconds.toString()}"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              );
            } else if (exercises[index].isTimerExercise) {
              return Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text("Exercise: ${exercises[index].title}"),
                        Text(
                            "ExerciseTime: ${exercises[index].timerTimeMinutes.toString()}:${exercises[index].timerTimeSeconds.toString()}"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              );
            }
          }),
    );
  }
}
