import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/bloc/run_workout_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/run_exercise_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/presentation/workout_timer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../core/strings/strings.dart';
import '../../widgets/workout_entities/entity/exercise_entity.dart';
import '../widgets/run_rest_screen.dart';

class RunWorkoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ExerciseEntity> exercises =
        ModalRoute.of(context)!.settings.arguments as List<ExerciseEntity>;

    WorkoutTimerWidget workoutTimerWidget = WorkoutTimerWidget();

    return BlocProvider(
      create: (BuildContext context) => RunWorkoutBloc(exercises, 0),
      child: Scaffold(
        body: BlocBuilder<RunWorkoutBloc, RunWorkoutState>(
            builder: (context, state) {
          if (state is WorkoutInProcess) {
            return buildRunExerciseScreen(
                state.exercises[state.currentExercise].title, workoutTimerWidget);
          }
          return CircularProgressIndicator();
        }),
      ),
    );
  }
}
