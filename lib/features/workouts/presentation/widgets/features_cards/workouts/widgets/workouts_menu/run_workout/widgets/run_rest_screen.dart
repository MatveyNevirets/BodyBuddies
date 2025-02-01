import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/bloc/run_workout_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/widgets/workout_timer/presentation/workout_timer_widget.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../core/widgets/base_button.dart';

Container buildRestScreen(BuildContext context, ExerciseEntity exercise, WorkoutTimerWidget workoutTimerWidget) {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 64),
    child: Card(
      color: Colours.workout_card_background_color,
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            buildWorkoutTimeWidget(workoutTimerWidget),
            const SizedBox(
              height: 16,
            ),
            buildRestTextWidget(),
            const SizedBox(
              height: 16,
            ),
            BaseButton(
                onClick: () => nextOnExercisesList(context),
                buttonText: Strings.skip,
                icon: null,
                isElevated: true),
          ],
        ),
      ),
    ),
  );
}

Container buildWorkoutTimeWidget(WorkoutTimerWidget workoutTimerWidget) {
  return Container(
    padding: const EdgeInsets.all(16),
    color: Colours.workoutCardForegroundColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Время"),
        workoutTimerWidget,
      ],
    ),
  );
}

Container buildRestTextWidget() {
  return Container(
    padding: const EdgeInsets.all(16),
    color: Colours.workoutCardForegroundColor,
    child: const Column(
      children: [
        Text("Отдых"),
        Text("60"),
      ],
    ),
  );
}

void nextOnExercisesList(BuildContext context) {
  context.read<RunWorkoutBloc>().add(ExerciseRunEvent());
}


