import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'run_workout_event.dart';

part 'run_workout_state.dart';

class RunWorkoutBloc extends Bloc<RunWorkoutEvent, RunWorkoutState> {
  WorkoutsRepository workoutsRepository;
  SecureStorage storage;

  List<ExerciseEntity> exercises;
  int currentExercise = 0;
  int currentSets = 1;

  int workoutTimerDuration = 0;

  RunWorkoutBloc(this.exercises, this.currentExercise, this.workoutsRepository,
      this.storage)
      : super(WorkoutInProcess(
            exercises: exercises,
            currentExercise: currentExercise,
            duration: 0)) {
    on<ExerciseRestEvent>(onWorkoutRested);
    on<ExerciseRunEvent>(onExerciseStarted);
    on<WorkoutCompleteEvent>(onWorkoutCompete);
  }

  onExerciseStarted(ExerciseRunEvent event, Emitter<RunWorkoutState> emit) {
    emit(LoadingState(exercises: [], currentExercise: 0, duration: 0));
    exercises[currentExercise].currentSets = currentSets;
    emit(
      WorkoutInProcess(
          exercises: exercises,
          currentExercise: currentExercise,
          duration: event.workoutTimerDuration),
    );
  }

  onWorkoutCompete(
      WorkoutCompleteEvent event, Emitter<RunWorkoutState> emit) async {
    emit(LoadingState(exercises: [], currentExercise: 0, duration: 0));
    try {
      final jsonToken = await storage.read(AppConsts.tokenKey);
      final mapToken = jsonDecode(jsonToken);
      final token = mapToken['access_token'];

      await workoutsRepository.addJournalWorkout(event.workoutEntity, token);

      emit(CompleteWorkout(exercises: [], currentExercise: 0, duration: 0));
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }

  onWorkoutRested(ExerciseRestEvent event, Emitter<RunWorkoutState> emit) {
    if (currentSets < exercises[currentExercise].sets) {
      currentSets++;
      emit(RestWorkoutProcess(
          exercises: exercises,
          currentExercise: currentExercise,
          duration: event.workoutTimerDuration));
    } else {
      currentSets = 1;
      emit(RestWorkoutProcess(
          exercises: exercises,
          currentExercise: currentExercise++,
          duration: event.workoutTimerDuration));
    }
  }
}
