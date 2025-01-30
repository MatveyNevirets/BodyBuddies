import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/bloc/workouts_menu_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../widgets/workout_entities/entity/exercise_entity.dart';

part 'run_workout_event.dart';

part 'run_workout_state.dart';

class RunWorkoutBloc extends Bloc<RunWorkoutEvent, RunWorkoutState> {
  List<ExerciseEntity> exercises;
  int currentExercise;

  RunWorkoutBloc(this.exercises, this.currentExercise)
      : super(WorkoutInProcess(exercises: exercises, currentExercise: currentExercise)) {
    on<RunWorkoutEvent>((event, emit) {

    });

    int lastExercise = exercises.length;
  }
}
