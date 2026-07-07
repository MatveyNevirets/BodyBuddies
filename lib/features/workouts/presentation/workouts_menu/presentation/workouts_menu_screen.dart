// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/themes/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';

import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/presentation/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/widgets/open_journal_card.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/widgets/workout_card_on_list.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsMenuScreen extends StatefulWidget {
  const WorkoutsMenuScreen(
      {super.key,
      required this.isConnection,
      required this.secureStorage,
      required this.workoutsRepository});

  final bool isConnection;
  final SecureStorage secureStorage;
  final WorkoutsRepository workoutsRepository;

  @override
  State<WorkoutsMenuScreen> createState() => _WorkoutsMenuScreenState();
}

class _WorkoutsMenuScreenState extends State<WorkoutsMenuScreen> {
  @override
  Widget build(BuildContext context) {
    createWorkout() {
      if (widget.isConnection) {
        Navigator.of(context).pushNamed(
          "/workouts_menu/create_workout/",
          arguments: [
            context,
            WorkoutEntity(title: "title", exercises: []),
            false,
          ],
        );
      } else {
        showSnackBar(context, Strings.haventInternetConnetion);
      }
    }

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 32),
        child: FloatingActionButton(
          elevation: 3,
          onPressed: () => createWorkout(),
          backgroundColor: Colours.workoutCardForegroundColor,
          foregroundColor: Colours.workout_card_background_color,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
      body: BlocBuilder<WorkoutsMenuBloc, WorkoutsMenuState>(
        builder: (context, state) {
          if (state is UpdateWorkoutState) {
            return Container(
              margin: DarkTheme.base_margin_size,
              child: ListView.builder(
                itemCount: state.workouts.length + 1,
                itemBuilder: (context, index) {
                  return index == 0
                      ? OpenWorkoutsJournal()
                      : WorkoutCardOnList(
                          workoutMenuContext: context,
                          workout: state.workouts.elementAt(index - 1),
                          index: index - 1,
                          isConnection: widget.isConnection,
                          secureStorage: widget.secureStorage,
                          workoutsRepository: widget.workoutsRepository,
                        );
                },
              ),
            );
          }

          return const LoadingScreen();
        },
      ),
    );
  }
}
