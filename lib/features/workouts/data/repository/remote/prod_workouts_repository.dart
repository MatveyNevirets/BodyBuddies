import 'dart:developer';

import 'package:body_buddies/features/workouts/data/Models/workout_model.dart';
import 'package:body_buddies/features/workouts/data/repository/local/local_workouts_repository.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/local_workouts_repository.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/generated/bodybuddies_workouts.pbgrpc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grpc/grpc_or_grpcweb.dart';

class ProdWorkoutsRepository implements WorkoutsRepository {
  late final WorkoutsRpcClient _client;
  late final WorkoutsRepository localWorkoutsRepository;

  ProdWorkoutsRepository({required LocalDatabase localDatabase}) {
    localDatabase.initDatabase();
    localWorkoutsRepository =
        LocalWorkoutsRepository(localDatabase: localDatabase);

    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: dotenv.env['SERVER_HOST']!,
        port: int.tryParse(dotenv.env['NGINX_PORT']!)!,
        transportSecure: false);

    _client = WorkoutsRpcClient(channel);
  }

  List<WorkoutModel> parseFromJson(Map<String, dynamic> json) {
    final workouts = json['workouts'] as List;
    return workouts.map((workout) => WorkoutModel.fromJson(workout)).toList();
  }

  @override
  Future<List<WorkoutEntity>> fetchAllWorkout(String token) async {
    try {
      final response = await _client.fetchAllWorkouts(
        RequestDto(),
        options: CallOptions(
          metadata: {'token': token},
        ),
      );

      List<WorkoutDto> workoutsDto = response.workouts;
      final workouts = workoutsDto
          .map((dto) => WorkoutModel(
              id: int.parse(dto.id),
              title: dto.title,
              weekday: int.parse(dto.weekday),
              exercises: convertExerciseFromDto(dto.exercises)))
          .toList();

      return workouts;
    } catch (e) {
      final workouts = await localWorkoutsRepository.fetchAllWorkout(token);
      return workouts;
    }
  }

  @override
  String get name => "Prod workouts repository";

  @override
  Future<void> createWorkout(String title, int weekday,
      List<ExerciseEntity> exercises, String token) async {
    try {
      final workoutId = await _client.addWorkout(
          WorkoutDto(title: title, weekday: weekday.toString(), exercises: []),
          options: CallOptions(metadata: {"token": token}));

      for (ExerciseEntity entity in exercises) {
        await _client.addExercise(
            ExerciseDto(
              workoutId: workoutId.message,
              title: entity.title,
              weight: entity.kilograms.toString(),
              reps: entity.reps.toString(),
              sets: entity.sets.toString(),
              restTimeMinutes: entity.restTimeInMinutes.toString(),
              restTimeSeconds: entity.restTimeInSeconds.toString(),
              exerciseTimeMinutes: entity.timerTimeMinutes.toString(),
              exerciseTimeSeconds: entity.timerTimeSeconds.toString(),
              isExercise: entity.isExercise,
              isTimerExercise: entity.isTimerExercise,
            ),
            options: CallOptions(metadata: {"token": token}));
      }

      await localWorkoutsRepository.createWorkout(
          title, weekday, exercises, token);
    } on Object catch (error, stack) {
      throw Exception("Error: $error and stack: $stack");
    }
  }

  @override
  Future<void> deleteWorkout(int index, String token) async {
    try {
      final workoutsDto = await _client.fetchAllWorkouts(RequestDto(),
          options: CallOptions(metadata: {"token": token}));
      final workouts = workoutsDto.workouts;

      await _client.deleteWorkout(WorkoutDto(title: workouts[index].title),
          options: CallOptions(metadata: {"token": token}));

      await localWorkoutsRepository.deleteWorkout(index, token);
    } on Object catch (error, stack) {
      throw Exception("Error: $error and stack: $stack");
    }
  }

  @override
  Future<void> updateWorkout(String? title, int? weekday,
      List<ExerciseEntity>? exercises, int id, String token) async {
    await _client.updateWorkout(
        WorkoutDto(
            id: id.toString(), title: title!, weekday: weekday.toString()),
        options: CallOptions(metadata: {"token": token}));

    final workout = await _client.fetchWorkout(WorkoutDto(title: title),
        options: CallOptions(metadata: {"token": token}));

    for (ExerciseDto exercise in workout.exercises) {
      await _client.deleteExercise(
          ExerciseDto(workoutId: id.toString(), title: exercise.title),
          options: CallOptions(metadata: {"token": token}));
    }

    for (ExerciseEntity exercise in exercises!) {
      await _client.addExercise(
          ExerciseDto(
            workoutId: id.toString(),
            title: exercise.title,
            weight: exercise.kilograms.toString(),
            reps: exercise.reps.toString(),
            sets: exercise.sets.toString(),
            restTimeMinutes: exercise.restTimeInMinutes.toString(),
            restTimeSeconds: exercise.restTimeInSeconds.toString(),
            exerciseTimeMinutes: exercise.timerTimeMinutes.toString(),
            exerciseTimeSeconds: exercise.timerTimeSeconds.toString(),
            isExercise: exercise.isExercise,
            isTimerExercise: exercise.isTimerExercise,
          ),
          options: CallOptions(metadata: {"token": token}));
    }
  }

  @override
  Future<void> addJournalWorkout(WorkoutEntity workout, String token) async {
    try {
      final response = await _client.addJournalWorkout(
          JournalWorkoutDto(
              duration: workout.duration,
              title: workout.title,
              date: workout.date),
          options: CallOptions(metadata: {"token": token}));

      for (ExerciseEntity exercise in workout.exercises) {
        await _client.addJournalExercise(
            ExerciseDto(
              workoutId: response.message,
              title: exercise.title,
              weight: exercise.kilograms.toString(),
              reps: exercise.reps.toString(),
              sets: exercise.sets.toString(),
              restTimeMinutes: exercise.restTimeInMinutes.toString(),
              restTimeSeconds: exercise.restTimeInSeconds.toString(),
              exerciseTimeMinutes: exercise.timerTimeMinutes.toString(),
              exerciseTimeSeconds: exercise.timerTimeSeconds.toString(),
              isExercise: exercise.isExercise,
              isTimerExercise: exercise.isTimerExercise,
            ),
            options: CallOptions(metadata: {"token": token}));
      }

      await localWorkoutsRepository.addJournalWorkout(workout, token);
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }

  @override
  Future<void> deleteJournalWorkout(WorkoutEntity workout, String token) async {
    try {
      await _client.deleteJournalWorkout(
          JournalWorkoutDto(
              id: workout.id.toString(),
              title: workout.title,
              date: workout.date,
              duration: workout.duration),
          options: CallOptions(metadata: {"token": token}));

      await localWorkoutsRepository.deleteJournalWorkout(workout, token);
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }

  @override
  Future<List<WorkoutEntity>> fetchJournalWorkouts(String token) async {
    try {
      final response = await _client.fetchJournalWorkouts(RequestDto(),
          options: CallOptions(metadata: {"token": token}));

      return response.workouts
          .map((workout) => WorkoutEntity(
              id: int.parse(workout.id),
              title: workout.title,
              exercises: convertExerciseFromDto(workout.exercises),
              date: workout.date,
              duration: workout.duration))
          .toList();
    } on Object catch (error, stack) {
      log("Journal fetch error: $error StackTrace: $stack");
      final journalWorkouts =
          await localWorkoutsRepository.fetchJournalWorkouts(token);
      return journalWorkouts;
    }
  }

  @override
  Future<void> deleteLocalDatabase() async {
    await localWorkoutsRepository.deleteLocalDatabase();
  }
}

List<ExerciseEntity> convertExerciseFromDto(List<ExerciseDto> exerciseDto) {
  return exerciseDto
      .map(
        (dto) => ExerciseEntity(
          title: dto.title,
          kilograms: double.parse(dto.weight),
          reps: int.parse(dto.reps),
          sets: int.parse(dto.sets),
          restTimeInMinutes: int.parse(dto.restTimeMinutes),
          restTimeInSeconds: int.parse(dto.restTimeSeconds),
          timerTimeMinutes: int.parse(dto.exerciseTimeMinutes),
          timerTimeSeconds: int.parse(dto.exerciseTimeSeconds),
          isExercise: dto.isExercise,
          isTimerExercise: dto.isTimerExercise,
        ),
      )
      .toList();
}

List<ExerciseDto> convertExerciseToDto(List<ExerciseEntity> exerciseEntity) {
  return exerciseEntity
      .map(
        (entity) => ExerciseDto(
          title: entity.title,
          weight: entity.kilograms.toString(),
          reps: entity.reps.toString(),
          sets: entity.sets.toString(),
          restTimeMinutes: entity.restTimeInMinutes.toString(),
          restTimeSeconds: entity.restTimeInSeconds.toString(),
          exerciseTimeMinutes: entity.timerTimeMinutes.toString(),
          exerciseTimeSeconds: entity.timerTimeSeconds.toString(),
          isExercise: entity.isExercise,
          isTimerExercise: entity.isTimerExercise,
        ),
      )
      .toList();
}
