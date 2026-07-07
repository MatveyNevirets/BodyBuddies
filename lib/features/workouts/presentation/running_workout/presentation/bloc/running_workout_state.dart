// ignore_for_file: must_be_immutable

part of 'running_workout_bloc.dart';

@immutable
sealed class RunningWorkoutState extends Equatable {
  List<ExerciseEntity> exercises;
  int currentExercise;
  int duration;

  RunningWorkoutState({
    required this.exercises,
    required this.currentExercise,
    required this.duration,
  });

  @override
  List<Object?> get props => [exercises, currentExercise];
}

class WorkoutInProcess extends RunningWorkoutState {
  WorkoutInProcess(
      {required super.exercises,
      required super.currentExercise,
      required super.duration});
}

class RunTimerInProgress extends RunningWorkoutState {
  RunTimerInProgress(
      {required super.exercises,
      required super.currentExercise,
      required super.duration});
}

class RestWorkoutProcess extends RunningWorkoutState {
  RestWorkoutProcess(
      {required super.exercises,
      required super.currentExercise,
      required super.duration});
}

class CompleteWorkout extends RunningWorkoutState {
  CompleteWorkout(
      {required super.exercises,
      required super.currentExercise,
      required super.duration});
}

class LoadingState extends RunningWorkoutState {
  LoadingState(
      {required super.exercises,
      required super.currentExercise,
      required super.duration});
}
