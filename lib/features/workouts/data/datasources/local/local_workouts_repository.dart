import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';

class LocalWorkoutsRepository implements WorkoutsRepository {
  @override
  Future<void> addJournalWorkout(WorkoutEntity workout, String token) {
    // TODO: implement addJournalWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> createWorkout(
      String title, int weekday, List<ExerciseEntity> exercises, String token) {
    // TODO: implement createWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> deleteJournalWorkout(WorkoutEntity workout, String token) {
    // TODO: implement deleteJournalWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWorkout(int index, String token) {
    // TODO: implement deleteWorkout
    throw UnimplementedError();
  }

  @override
  Future<List<WorkoutEntity>> fetchAllWorkout(String token) {
    // TODO: implement fetchAllWorkout
    throw UnimplementedError();
  }

  @override
  Future<List<WorkoutEntity>> fetchJournalWorkouts(String token) {
    // TODO: implement fetchJournalWorkouts
    throw UnimplementedError();
  }

  @override
  // TODO: implement name
  String get name => "Local workouts repository";

  @override
  Future<void> updateWorkout(String? title, int? weekday,
      List<ExerciseEntity>? exercises, int index, String token) {
    // TODO: implement updateWorkout
    throw UnimplementedError();
  }
}
