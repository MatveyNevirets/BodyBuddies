import 'package:body_buddies/features/workouts/presentation/workouts_menu/domain/entity/workout_entity.dart';

abstract interface class WorkoutsRepository {
  String get name;

  Future<List<WorkoutEntity>> fetchAllWorkout();
}
