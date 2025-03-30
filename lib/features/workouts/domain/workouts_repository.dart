import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:flutter/widgets.dart';

abstract interface class WorkoutsRepository {
  String get name;

  Future<List<WorkoutEntity>> fetchAllWorkout(BuildContext context);

  Future<void> createWorkout(
      String title, int weekday, List<ExerciseEntity> exercises);

  Future<void> deleteWorkout(int index);

  Future<void> updateWorkout(
      String? title, int? weekday, List<ExerciseEntity>? exercises, int index);
}
