import 'package:body_buddies/features/useful/data/local_useful_sql_database.dart';
import 'package:body_buddies/features/useful/domain/entity/advice_entity.dart';
import 'package:body_buddies/features/useful/generated/bodybuddies_micro_features.pbgrpc.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:grpc/grpc_or_grpcweb.dart';

class ProdUsefulRepository implements UsefulRepository {
  late final MicroFeaturesRpcClient _client;
  late final LocalUsefulSqlDatabase usefulLocal;

  ProdUsefulRepository() {
    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: AppConsts.hostAddress,
        port: AppConsts.nginxPort,
        transportSecure: false);

    usefulLocal = LocalUsefulSqlDatabase();

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

      final advices = advicesDto.advices.map((advice) {
        usefulLocal.addAdvice(advice.title, advice.body);
        return AdviceEntity(title: advice.title, bodyText: advice.body);
      }).toList();

      return advices;
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }

  @override
  Future<List<WorkoutEntity>> fetchCreatedWorkouts(String token) async {
    try {
      final workouts = await _client.fetchAllWorkouts(RequestDto(),
          options: CallOptions(metadata: {"token": token}));

      return workouts.workouts
          .map((workout) => WorkoutEntity(
              title: workout.title,
              exercises: workout.exercises
                  .map(
                    (exercise) => ExerciseEntity(
                      title: exercise.title,
                      kilograms: double.parse(exercise.weight),
                      reps: int.parse(exercise.reps),
                      timerTimeMinutes: int.parse(exercise.exerciseTimeMinutes),
                      timerTimeSeconds: int.parse(exercise.exerciseTimeSeconds),
                      restTimeInMinutes: int.parse(exercise.restTimeMinutes),
                      restTimeInSeconds: int.parse(exercise.restTimeSeconds),
                      sets: int.parse(exercise.sets),
                      isExercise: exercise.isExercise,
                      isTimerExercise: exercise.isTimerExercise,
                    ),
                  )
                  .toList()))
          .toList();
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }
}
