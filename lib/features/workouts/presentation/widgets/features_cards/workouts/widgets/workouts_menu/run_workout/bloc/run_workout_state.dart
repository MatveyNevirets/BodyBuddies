part of 'run_workout_bloc.dart';

@immutable
sealed class RunWorkoutState {
}

class WorkoutInProcess extends RunWorkoutState {
  List<ExerciseEntity> exercises;
  int currentExercise;

  WorkoutInProcess({required this.exercises, required this.currentExercise});
}

class RestWorkoutProcess extends RunWorkoutState {
  List<ExerciseEntity> exercises;
  int currentExercise;

  RestWorkoutProcess({required this.exercises, required this.currentExercise});
}
