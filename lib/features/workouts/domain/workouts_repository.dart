import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_on_list_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:flutter/widgets.dart';

abstract interface class WorkoutsRepository {
  String get name;

  Future<List<WorkoutEntity>> fetchAllWorkout(BuildContext context);

  Future<void> createWorkout(String title, int weekday,
      List<ExerciseEntity> exercises, BuildContext context);

  Future<void> deleteWorkout(int index, BuildContext context);

  Future<void> updateWorkout(
      String? title, int? weekday, List<ExerciseEntity>? exercises, int index);

  Future<List<ExerciseOnListEntity>> fetchAllExercisesToAddList(
      BuildContext context);
}
