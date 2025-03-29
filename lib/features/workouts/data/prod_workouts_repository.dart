import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:grpc/grpc_or_grpcweb.dart';

class ProdWorkoutsRepository implements WorkoutsRepository {
  ProdWorkoutsRepository() {
    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: "", port: 0000, transportSecure: false);
  }

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

  @override
  Future<void> deleteWorkout(int index) {
    // TODO: implement deleteWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> updateWorkout(
      String? title, int? weekday, List<ExerciseEntity>? exercises, int index) {
    // TODO: implement updateWorkout
    throw UnimplementedError();
  }
}
