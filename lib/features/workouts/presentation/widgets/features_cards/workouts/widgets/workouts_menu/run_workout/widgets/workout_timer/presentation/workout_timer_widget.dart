import 'dart:async';

import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/bloc/workout_timer_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/workout_ticker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutTimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        final bloc = WorkoutTimerBloc(ticker: WorkoutTicker());
        bloc.add(TimerStarted(0));
        return bloc;
      },
      child: BlocBuilder<WorkoutTimerBloc, WorkoutTimerState>(
        builder: (context, state) {
          return Text(getTime(state.duration));
        },
      ),
    );
  }

  String getTime(int duration) {
    String minutesToStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, "0");
    String secondsToStr = (duration % 60).floor().toString().padLeft(2, "0");
    return "$minutesToStr:$secondsToStr";
  }
}
