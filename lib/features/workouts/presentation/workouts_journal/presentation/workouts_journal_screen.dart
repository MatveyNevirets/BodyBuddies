import 'package:body_buddies/core/widgets/are_you_sure_dialog.dart';
import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/bloc/journal_workouts_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/widgets/journal_workout_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/strings/strings.dart';

class WorkoutsJournalScreen extends StatelessWidget {
  const WorkoutsJournalScreen({super.key, required this.isConnection});

  final bool isConnection;

  @override
  Widget build(BuildContext context) {
    void removeCurrentWorkout(int index) {
      if (isConnection) {
        context
            .read<JournalWorkoutsBloc>()
            .add(DeleteJournalWorkoutEvent(index: index));
      } else {
        showSnackBar(context, Strings.haventInternetConnetion);
      }
    }

    return Scaffold(
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
                        removeItem: () {
                          showAdaptiveDialog(
                              context: context,
                              builder: (context) {
                                return _AreYouSureJournalDialog(
                                  isConnection: isConnection,
                                  index: index,
                                  onSubmit: () => removeCurrentWorkout(index),
                                );
                              });
                        },
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

class _AreYouSureJournalDialog extends StatelessWidget {
  final VoidCallback onSubmit;

  const _AreYouSureJournalDialog(
      {required this.isConnection,
      required this.index,
      required this.onSubmit});

  final bool isConnection;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AreYouSureDialog(
      onSubmit: () {
        if (isConnection) {
          try {
            Navigator.of(context).pop();
            onSubmit.call();
          } on Object catch (error, stack) {
            throw Exception("Error: $error, StackTrace: $stack");
          }
        } else {
          showSnackBar(context, Strings.haventInternetConnetion);
        }
      },
    );
  }
}
