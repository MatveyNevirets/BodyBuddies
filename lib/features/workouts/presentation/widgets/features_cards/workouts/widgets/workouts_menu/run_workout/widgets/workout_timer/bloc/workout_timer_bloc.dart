import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/workout_ticker.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'workout_timer_event.dart';

part 'workout_timer_state.dart';

class WorkoutTimerBloc extends Bloc<WorkoutTimerEvent, WorkoutTimerState> {
  late WorkoutTicker _ticker;
  StreamSubscription<int>? subscription;

  WorkoutTimerBloc({required WorkoutTicker ticker})
      : _ticker = ticker,
        super(WorkoutTimerInitial(0)) {
    on<TimerStarted>(onStarted);
    on<OnTicked>(onTimerTick);
  }

  void onStarted(TimerStarted event, Emitter<WorkoutTimerState> emit) {
    emit(RunInProgress(event.duration));
    subscription?.cancel();
    subscription =
        _ticker.workoutTick().listen((duration) => add(OnTicked(duration)));
  }

  void onTimerTick(OnTicked event, Emitter<WorkoutTimerState> emit) {
    emit(RunInProgress(event.duration));
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
