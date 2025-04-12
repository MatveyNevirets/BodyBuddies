// ignore_for_file: must_be_immutable

part of 'run_workout_bloc.dart';

@immutable
sealed class RunWorkoutState extends Equatable {
  List<ExerciseEntity> exercises;
  int currentExercise;
  int duration;

  RunWorkoutState({
    required this.exercises,
    required this.currentExercise,
    required this.duration,
  });

  @override
  List<Object?> get props => [exercises, currentExercise];
}

class WorkoutInProcess extends RunWorkoutState {
  WorkoutInProcess(
      {required super.exercises,
      required super.currentExercise,
      required super.duration});
}

class RunTimerInProgress extends RunWorkoutState {
  RunTimerInProgress(
      {required super.exercises,
      required super.currentExercise,
      required super.duration});
}

class RestWorkoutProcess extends RunWorkoutState {
  RestWorkoutProcess(
      {required super.exercises,
      required super.currentExercise,
      required super.duration});
}

class CompleteWorkout extends RunWorkoutState {
  CompleteWorkout(
      {required super.exercises,
      required super.currentExercise,
      required super.duration});
}

class LoadingState extends RunWorkoutState {
  LoadingState(
      {required super.exercises,
      required super.currentExercise,
      required super.duration});
}
