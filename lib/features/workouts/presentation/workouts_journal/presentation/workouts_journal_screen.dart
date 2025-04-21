import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/bloc/journal_workouts_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/widgets/journal_workout_card_item.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/strings/strings.dart';

class WorkoutsJournalScreen extends StatelessWidget {
  const WorkoutsJournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void removeCurrentWorkout(int index) {
      final isConnection = AppDependsProvider.of(context).isConnection;

      if (isConnection) {
        context
            .read<JournalWorkoutsBloc>()
            .add(DeleteJournalWorkoutEvent(index: index));
      } else {
        showSnackBar(context, Strings.haventInternetConnetion);
      }
    }

    return Scaffold(
      appBar:
          createAppBarWidget(appbarTitle: Strings.journal, context: context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 5,
          color: Colours.workout_card_background_color,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<JournalWorkoutsBloc, JournalWorkoutsState>(
              builder: (context, state) {
                if (state is FetchJournalState) {
                  return ListView.builder(
                    itemCount: state.journalWorkouts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return JournalWorkoutCardItem(
                        state.journalWorkouts[index],
                        removeItem: () => removeCurrentWorkout(index),
                      );
                    },
                  );
                }
                return const LoadingScreen();
              },
            ),
          ),
        ),
      ),
    );
  }
}
