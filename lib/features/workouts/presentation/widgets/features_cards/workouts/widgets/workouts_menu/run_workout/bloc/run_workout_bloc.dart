import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../widgets/workout_entities/entity/exercise_entity.dart';

part 'run_workout_event.dart';
part 'run_workout_state.dart';

class RunWorkoutBloc extends Bloc<RunWorkoutEvent, RunWorkoutState> {

  List<ExerciseEntity> exercises;

  RunWorkoutBloc(this.exercises) : super(RunWorkoutInitial()) {
    on<RunWorkoutEvent>((event, emit) {

    });
  }

  onStartWorkout() {

  }
}
