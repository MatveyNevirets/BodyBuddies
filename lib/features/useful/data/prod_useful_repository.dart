import 'package:body_buddies/features/useful/domain/entity/advice_entity.dart';
import 'package:body_buddies/features/useful/generated/bodybuddies_micro_features.pbgrpc.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:grpc/grpc_or_grpcweb.dart';

class ProdUsefulRepository implements UsefulRepository {
  late final MicroFeaturesRpcClient _client;

  ProdUsefulRepository() {
    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: AppConsts.hostAddress,
        port: AppConsts.usefulPort,
        transportSecure: false);

    _client = MicroFeaturesRpcClient(channel);
  }

  @override
  Future<List<ExerciseOnListEntity>> fetchExercises(String token) async {
    try {
      final exercisesDto = await _client.fetchAllExercises(RequestDto(),
          options: CallOptions(metadata: {"token": token}));

      final exercises = exercisesDto.exercises
          .map((exercise) => ExerciseOnListEntity(
              title: exercise.title, isExercise: exercise.isExercise))
          .toList();

      return exercises;
    } catch (error, stack) {
      throw Exception("Error: $error StackTrace: $stack");
    }
  }

  @override
  String get name => "Prod useful repository";

  @override
  Future<List<AdviceEntity>> fetchAdvices(String token) async {
    try {
      final advicesDto = await _client.fetchAllAdvices(RequestDto(),
          options: CallOptions(metadata: {"token": token}));

      return advicesDto.advices
          .map((advice) =>
              AdviceEntity(title: advice.title, bodyText: advice.body))
          .toList();
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }

  @override
  Future<List<WorkoutEntity>> fetchCreatedWorkouts(String token) {
    // TODO: implement fetchCreatedWorkouts
    throw UnimplementedError();
  }
}
