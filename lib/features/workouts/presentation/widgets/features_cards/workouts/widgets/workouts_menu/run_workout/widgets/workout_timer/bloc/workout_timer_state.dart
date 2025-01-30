part of 'workout_timer_bloc.dart';

@immutable
sealed class WorkoutTimerState extends Equatable{
  int duration;
  WorkoutTimerState(this.duration);

  @override
  // TODO: implement props
  List<Object?> get props => [duration];
}

final class WorkoutTimerInitial extends WorkoutTimerState {
  WorkoutTimerInitial(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

class TickTimerState extends WorkoutTimerState {
  TickTimerState(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

class RunInProgress extends WorkoutTimerState {
  RunInProgress(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}