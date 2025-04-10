import 'dart:convert';
import 'dart:developer';

import 'package:body_buddies/features/workouts/data/Models/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/generated/bodybuddies_workouts.pbgrpc.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:grpc/grpc_or_grpcweb.dart';

class ProdWorkoutsRepository implements WorkoutsRepository {
  late final WorkoutsRpcClient _client;

  ProdWorkoutsRepository() {
    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: AppConsts.hostAddress,
        port: AppConsts.workoutsPort,
        transportSecure: false);

    _client = WorkoutsRpcClient(channel);
  }

  List<WorkoutModel> parseFromJson(Map<String, dynamic> json) {
    final workouts = json['workouts'] as List;
    return workouts.map((workout) => WorkoutModel.fromJson(workout)).toList();
  }

  @override
  Future<List<WorkoutEntity>> fetchAllWorkout(BuildContext context) async {
    final storage = AppDependsProvider.of(context).secureStorage;

    try {
      final tokens = await storage.read(AppConsts.tokenKey);
      final jsonString = jsonDecode(tokens);
      final token = jsonString['access_token'];

      final response = await _client.fetchAllWorkouts(
        RequestDto(),
        options: CallOptions(
          metadata: {'token': token},
        ),
      );

      List<WorkoutDto> workoutsDto = response.workouts;
      final workouts = workoutsDto
          .map((dto) => WorkoutModel(
              title: dto.title,
              weekday: int.parse(dto.weekday),
              exercises: convertExerciseFromDto(dto.exercises)))
          .toList();

      return workouts;
    } catch (e) {
      log("Error on fetch workout: $e");
      return [];
    }
  }

  @override
  String get name => "Prod workouts repository";

  @override
  Future<void> createWorkout(String title, int weekday,
      List<ExerciseEntity> exercises, BuildContext context) async {
    final storage = AppDependsProvider.of(context).secureStorage;

    try {
      final tokenJson = await storage.read(AppConsts.tokenKey);
      final tokenMap = jsonDecode(tokenJson);
      final token = tokenMap['access_token'];

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
    } on Object catch (error, stack) {
      throw Exception("Error: $error and stack: $stack");
    }
  }

  @override
  Future<void> deleteWorkout(int index, BuildContext context) async {
    final storage = AppDependsProvider.of(context).secureStorage;
    try {
      final tokenJson = await storage.read(AppConsts.tokenKey);
      final tokenMap = jsonDecode(tokenJson);
      final token = tokenMap['access_token'];

      final workoutsDto = await _client.fetchAllWorkouts(RequestDto(),
          options: CallOptions(metadata: {"token": token}));
      final workouts = workoutsDto.workouts;

      await _client.deleteWorkout(WorkoutDto(title: workouts[index].title),
          options: CallOptions(metadata: {"token": token}));
    } on Object catch (error, stack) {
      throw Exception("Error: $error and stack: $stack");
    }
  }

  @override
  Future<void> updateWorkout(String? title, int? weekday,
      List<ExerciseEntity>? exercises, int index, BuildContext context) async {
    // final storage = AppDependsProvider.of(context).secureStorage;
    // try {
    //   final tokenJson = await storage.read(AppConsts.tokenKey);
    //   final tokenMap = jsonDecode(tokenJson);
    //   final token = tokenMap['access_token'];

    //   final workoutsDto = await _client.fetchAllWorkouts(RequestDto(),
    //       options: CallOptions(metadata: {"token": token}));
    //   final workout = workoutsDto.workouts[index];

    //   await _client.updateWorkout(
    //       WorkoutDto(
    //           id: workout.id,
    //           authorId: workout.authorId,
    //           title: title ?? workout.title,
    //           weekday: workout.weekday == weekday.toString()
    //               ? workout.weekday
    //               : weekday.toString()),
    //       options: CallOptions(metadata: {"token": token}));

    //   // for(ExerciseEntity exercise in exercises!) {
    //   //   await _client.updateExercise(ExerciseDto(id: ))
    //   // }
    // } on Object catch (error, stack) {
    //   throw Exception("Error: $error and stack: $stack");
    // }
  }

  @override
  Future<List<ExerciseOnListEntity>> fetchAllExercisesToAddList(
      BuildContext context) async {
    final storage = AppDependsProvider.of(context).secureStorage;
    try {
      final tokenJson = await storage.read(AppConsts.tokenKey);
      final tokenMap = jsonDecode(tokenJson);
      final token = tokenMap['access_token'];

      final response = await _client.fetchAllExercises(RequestDto(),
          options: CallOptions(metadata: {"token": token}));

      return convertExerciseToListFromDto(response.exercises);
    } on Object catch (error, stack) {
      throw Exception("Error: $error and stack: $stack");
    }
  }
}

List<ExerciseOnListEntity> convertExerciseToListFromDto(
    List<ExerciseOnListDto> exercises) {
  return exercises
      .map((exericse) => ExerciseOnListEntity(
          title: exericse.title, isExercise: exericse.isExercise))
      .toList();
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
