import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../widgets/workout_entities/entity/exercise_entity.dart';
import '../widgets/workout_timer/workout_ticker.dart';

part 'run_workout_event.dart';

part 'run_workout_state.dart';

class RunWorkoutBloc extends Bloc<RunWorkoutEvent, RunWorkoutState> {
  List<ExerciseEntity> exercises;
  int currentExercise = 0;
  int currentSets = 1;

  /// timer

  int duration = 0;

  RunWorkoutBloc(this.exercises, this.currentExercise)
      : super(WorkoutInProcess(
            exercises: exercises,
            currentExercise: currentExercise,
            duration: 0)) {
    on<ExerciseRestEvent>(onWorkoutRested);
    on<ExerciseRunEvent>(onExerciseStarted);
  }

  onExerciseStarted(ExerciseRunEvent event, Emitter<RunWorkoutState> emit) {
    exercises[currentExercise].currentSets = currentSets;
    emit(
      WorkoutInProcess(
          exercises: exercises,
          currentExercise: currentExercise,
          duration: event.workoutTimerDuration),
    );
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
