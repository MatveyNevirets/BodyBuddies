import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/domain/entity/workout_entity.dart';

class MockWorkoutsRepository implements WorkoutsRepository {
  @override
  Future<List<WorkoutEntity>> fetchAllWorkout() {
    // TODO: implement fetchAllWorkout
    throw UnimplementedError();
  }

  @override
  String get name => "Mock workouts repository";
}
