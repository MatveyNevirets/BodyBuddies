part of 'running_workout_bloc.dart';

@immutable
sealed class RunningWorkoutEvent {
  int workoutTimerDuration;
  RunningWorkoutEvent(this.workoutTimerDuration);
}

class ExerciseRunEvent extends RunningWorkoutEvent {
  ExerciseRunEvent(super.workoutTimerDuration);
}

class ExerciseRestEvent extends RunningWorkoutEvent {
  ExerciseRestEvent(super.workoutTimerDuration);
}

class WorkoutCompleteEvent extends RunningWorkoutEvent {
  WorkoutEntity workoutEntity;
  WorkoutCompleteEvent(super.workoutTimerDuration, this.workoutEntity);
}
