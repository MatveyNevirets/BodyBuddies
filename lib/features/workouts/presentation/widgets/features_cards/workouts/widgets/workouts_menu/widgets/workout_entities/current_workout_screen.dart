import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/material.dart';

class WorkoutEntityScreen extends StatelessWidget {
  const WorkoutEntityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WorkoutEntity workoutEntity =
        ModalRoute.of(context)!.settings.arguments as WorkoutEntity;

    return Scaffold(
      body: ListView.builder(
          itemCount: workoutEntity.exercises.length,
          itemBuilder: (context, index) {
            if (workoutEntity.exercises[index].isExercise) {
              return Column(
                children: [
                  Text(workoutEntity.exercises[index].title),
                  Text(
                      "kg: ${workoutEntity.exercises[index].kilograms.toString()}"),
                  Text(
                      "sets: ${workoutEntity.exercises[index].sets.toString()}"),
                  Text(
                      "reps: ${workoutEntity.exercises[index].reps.toString()}"),
                  Text(
                      "ExerciseTime: ${workoutEntity.exercises[index].restTimeInMinutes.toString()}:${workoutEntity.exercises[index].restTimeInSeconds.toString()}"),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              );
            } else if (workoutEntity.exercises[index].isTimerExercise) {
              return Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                            "Exercise: ${workoutEntity.exercises[index].title}"),
                        Text(
                            "ExerciseTime: ${workoutEntity.exercises[index].timerTimeMinutes.toString()}:${workoutEntity.exercises[index].timerTimeSeconds.toString()}"),
                        Text(
                            "Sets: ${workoutEntity.exercises[index].sets.toString()} Weight: ${workoutEntity.exercises[index].kilograms.toString()}"),
                        Text(
                            "RestTime: ${workoutEntity.exercises[index].restTimeInMinutes.toString()}:${workoutEntity.exercises[index].restTimeInSeconds.toString()}"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              );
            }
            return const Text("Penis");
          }),
    );
  }
}
