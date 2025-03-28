import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/bloc/workouts_journal_cubit.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/widgets/journal_workout_card_item.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/domain/entity/workout_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/strings/strings.dart';

class WorkoutsJournalScreen extends StatelessWidget {
  const WorkoutsJournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBarWidget(appbarTitle: Strings.journal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 5,
          color: Colours.workout_card_background_color,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<WorkoutsJournalCubit, List<WorkoutEntity>>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (BuildContext context, int index) {
                    return JournalWorkoutCardItem(
                      state[index],
                      removeItem: () => context
                          .read<WorkoutsJournalCubit>()
                          .removeSavedWorkout(index),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
