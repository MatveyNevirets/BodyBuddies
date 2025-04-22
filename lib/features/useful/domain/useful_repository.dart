import 'package:body_buddies/features/useful/domain/entity/advice_entity.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';

abstract interface class UsefulRepository {
  String get name;

  Future<List<ExerciseOnListEntity>> fetchExercises(String token);
  Future<List<AdviceEntity>> fetchAdvices(String token);
  Future<List<WorkoutEntity>> fetchCreatedWorkouts(String token);
}
