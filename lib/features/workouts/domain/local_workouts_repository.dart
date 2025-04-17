import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class LocalWorkoutsRepository {
  String get name;

  Future<Database> getDatabase();

  Future<void> initDatabase();

  Future<List<WorkoutEntity>> fetchAllWorkout();

  Future<void> createWorkout(
      String title, int weekday, List<ExerciseEntity> exercises);

  Future<void> deleteWorkout(int index);

  Future<void> updateWorkout(
      String? title, int? weekday, List<ExerciseEntity>? exercises, int index);

  Future<void> addJournalWorkout(WorkoutEntity workout);
  Future<void> deleteJournalWorkout(WorkoutEntity workout);
  Future<List<WorkoutEntity>> fetchJournalWorkouts();
}
