import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:flutter/widgets.dart';

abstract interface class WorkoutsRepository {
  String get name;

  Future<List<WorkoutEntity>> fetchAllWorkout(String token);

  Future<void> createWorkout(
      String title, int weekday, List<ExerciseEntity> exercises, String token);

  Future<void> deleteWorkout(int index, String token);

  Future<void> updateWorkout(String? title, int? weekday,
      List<ExerciseEntity>? exercises, int index, String token);

  Future<List<ExerciseOnListEntity>> fetchAllExercisesToAddList(
      BuildContext context);

  Future<void> addJournalWorkout(WorkoutEntity workout, String token);
  Future<void> deleteJournalWorkout(WorkoutEntity workout, String token);
  Future<List<WorkoutEntity>> fetchJournalWorkouts(String token);
}
