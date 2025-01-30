part of 'run_workout_bloc.dart';

@immutable
sealed class RunWorkoutEvent {}


class WorkoutStarted extends RunWorkoutEvent {
  List<ExerciseEntity> exercises;
  WorkoutStarted(this.exercises);
}