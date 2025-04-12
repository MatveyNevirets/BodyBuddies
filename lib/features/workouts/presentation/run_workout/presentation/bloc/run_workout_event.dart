part of 'run_workout_bloc.dart';

@immutable
sealed class RunWorkoutEvent {
  int workoutTimerDuration;
  RunWorkoutEvent(this.workoutTimerDuration);
}

class ExerciseRunEvent extends RunWorkoutEvent {
  ExerciseRunEvent(super.workoutTimerDuration);
}

class ExerciseRestEvent extends RunWorkoutEvent {
  ExerciseRestEvent(super.workoutTimerDuration);
}

class WorkoutCompleteEvent extends RunWorkoutEvent {
  WorkoutEntity workoutEntity;
  WorkoutCompleteEvent(super.workoutTimerDuration, this.workoutEntity);
}
