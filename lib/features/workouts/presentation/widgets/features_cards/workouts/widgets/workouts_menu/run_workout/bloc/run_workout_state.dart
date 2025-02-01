// ignore_for_file: must_be_immutable

part of 'run_workout_bloc.dart';

@immutable
sealed class RunWorkoutState extends Equatable {
  List<ExerciseEntity> exercises;
  int currentExercise;

  RunWorkoutState({
    required this.exercises,
    required this.currentExercise,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [exercises, currentExercise];
}

class WorkoutInProcess extends RunWorkoutState {
  WorkoutInProcess({required super.exercises, required super.currentExercise});
}

class RestWorkoutProcess extends RunWorkoutState {
  RestWorkoutProcess({
    required super.exercises,
    required super.currentExercise,
  });
}

class CompleteWorkout extends RunWorkoutState {
  CompleteWorkout({
    required super.exercises,
    required super.currentExercise,
  });
}
