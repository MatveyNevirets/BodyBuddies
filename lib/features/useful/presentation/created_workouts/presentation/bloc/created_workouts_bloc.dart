import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'created_workouts_event.dart';
part 'created_workouts_state.dart';

class CreatedWorkoutsBloc
    extends Bloc<CreatedWorkoutsEvent, CreatedWorkoutsState> {
  final WorkoutsRepository workoutsRepository;
  final UsefulRepository usefulRepository;
  final SecureStorage storage;

  List<WorkoutEntity>? workouts;

  CreatedWorkoutsBloc(
      this.usefulRepository, this.storage, this.workoutsRepository)
      : super(CreatedWorkoutsInitial()) {
    on<FetchWorkoutsEvent>(_fetchWorkouts);
    on<AddCreatedWorkoutEvent>(_addWorkout);
  }

  Future<void> _fetchWorkouts(
      FetchWorkoutsEvent event, Emitter<CreatedWorkoutsState> emit) async {
    emit(LoadingState());
    try {
      final jsonToken = await storage.read(dotenv.env['TOKEN_KEY']!);
      final mapToken = jsonDecode(jsonToken);
      final token = mapToken['access_token'];

      workouts = await usefulRepository.fetchCreatedWorkouts(token);

      emit(FetchCreatedWorkoutsState(workouts: workouts!));
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }

  Future<void> _addWorkout(
      AddCreatedWorkoutEvent event, Emitter<CreatedWorkoutsState> emit) async {
    emit(LoadingState());
    try {
      final jsonToken = await storage.read(dotenv.env['TOKEN_KEY']!);
      final mapToken = jsonDecode(jsonToken);
      final token = mapToken['access_token'];

      final createdWorkout = workouts![event.index];

      final usersWorkouts = await workoutsRepository.fetchAllWorkout(token);

      if (usersWorkouts == null) {
        await workoutsRepository.createWorkout(createdWorkout.title!,
            createdWorkout.weekday, createdWorkout.exercises, token);
        emit(
            CreatedWorkoutAddedState(message: "Тренировка успешно добавлена!"));
      }

      for (int i = 0; i < usersWorkouts!.length; i++) {
        if (usersWorkouts[i].title == createdWorkout.title) {
          log("==");

          emit(CreatedWorkoutAddedState(
              message: "Тренировка уже была добавлена!"));
          emit(FetchCreatedWorkoutsState(workouts: workouts!));
          break;
        }

        if (i == usersWorkouts.length - 1) {
          await workoutsRepository.createWorkout(createdWorkout.title!,
              createdWorkout.weekday, createdWorkout.exercises, token);
          emit(CreatedWorkoutAddedState(
              message: "Тренировка успешно добавлена!"));
          emit(FetchCreatedWorkoutsState(workouts: workouts!));
        }
      }
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }
}
