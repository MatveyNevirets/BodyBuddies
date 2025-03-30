import 'dart:convert';
import 'dart:developer';

import 'package:body_buddies/features/auth/domain/tokens.dart';
import 'package:body_buddies/features/workouts/data/Models/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
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
        host: "185.43.5.250", port: 4002, transportSecure: false);

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
          .map((dto) => WorkoutModel(title: dto.title, exercises: []))
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
