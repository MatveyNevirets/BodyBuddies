import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/bloc/run_workout_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/run_exercise_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/presentation/workout_timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/workout_entities/entity/exercise_entity.dart';
import '../widgets/run_rest_screen.dart';

class RunWorkoutScreen extends StatelessWidget {
  const RunWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ExerciseEntity> exercises =
        ModalRoute.of(context)!.settings.arguments as List<ExerciseEntity>;

    WorkoutTimerWidget workoutTimerWidget = WorkoutTimerWidget();

    return BlocProvider(
      create: (BuildContext blocContext) => RunWorkoutBloc(exercises, 0),
      child: Scaffold(
        body: BlocBuilder<RunWorkoutBloc, RunWorkoutState>(
            builder: (context, state) {
          if (state is WorkoutInProcess) {
            return buildRunExerciseScreen(context, //TODO: Ебни их в отдельные классы, хуле они как методы, если по факту это разные экраны
                state.exercises[state.currentExercise], workoutTimerWidget);
          } else if (state is RestWorkoutProcess) {
            return buildRestScreen(context,
                state.exercises[state.currentExercise], workoutTimerWidget);
          }
          return const CircularProgressIndicator();
        }),
      ),
    );
  }
}
