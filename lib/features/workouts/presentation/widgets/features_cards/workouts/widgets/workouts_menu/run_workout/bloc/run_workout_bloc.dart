import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../widgets/workout_entities/entity/exercise_entity.dart';

part 'run_workout_event.dart';

part 'run_workout_state.dart';

class RunWorkoutBloc extends Bloc<RunWorkoutEvent, RunWorkoutState> {
  List<ExerciseEntity> exercises;
  int currentExercise = 0;
  int currentSets = 0;

  RunWorkoutBloc(this.exercises, this.currentExercise)
      : super(WorkoutInProcess(
            exercises: exercises, currentExercise: currentExercise)) {
    on<ExerciseRestEvent>(onWorkoutRested);
    on<ExerciseRunEvent>(onExerciseStarted);
    // int lastExercise = exercises.length;
  }

  onExerciseStarted(ExerciseRunEvent event, Emitter<RunWorkoutState> emit) {
    currentSets++;
    exercises[currentExercise].currentSets = currentSets;
    emit(
      WorkoutInProcess(exercises: exercises, currentExercise: currentExercise),
    );
  }

  onWorkoutRested(ExerciseRestEvent event, Emitter<RunWorkoutState> emit) {
    if (currentSets < exercises[currentExercise].sets) {
      emit(RestWorkoutProcess(
          exercises: exercises, currentExercise: currentExercise));
    } else {
      currentSets = 0;
      emit(RestWorkoutProcess(
          exercises: exercises, currentExercise: currentExercise++));
    }
  }
}
