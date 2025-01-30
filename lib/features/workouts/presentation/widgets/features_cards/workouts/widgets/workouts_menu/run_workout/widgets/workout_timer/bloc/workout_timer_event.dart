part of 'workout_timer_bloc.dart';

@immutable
sealed class WorkoutTimerEvent{}

class OnTicked extends WorkoutTimerEvent {
  int duration;
  OnTicked(this.duration);
}

class TimerStarted extends WorkoutTimerEvent {
  int duration;
  TimerStarted(this.duration);
}
