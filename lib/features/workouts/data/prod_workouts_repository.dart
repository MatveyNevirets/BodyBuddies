import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';

class ProdWorkoutsRepository implements WorkoutsRepository {
  @override
  Future<List<WorkoutEntity>> fetchAllWorkout() {
    // TODO: implement fetchAllWorkout
    throw UnimplementedError();
  }

  @override
  String get name => "Prod workouts repository";

  @override
  Future<void> createWorkout(
      String title, int weekday, List<ExerciseEntity> exercises) {
    // TODO: implement createWorkout
    throw UnimplementedError();
  }
}
