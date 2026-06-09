// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';

import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/are_you_sure_dialog.dart';
import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/presentation/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/widgets/new_workout_button.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/workout_create_screen.dart';
import 'package:body_buddies/internal/application/di/app_depends.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../../core/strings/strings.dart';

class WorkoutCardOnList extends StatelessWidget {
  WorkoutEntity workout;
  int index;
  BuildContext workoutMenuContext;

  WorkoutCardOnList(
      {super.key,
      required this.workoutMenuContext,
      required this.workout,
      required this.index});

  @override
  Widget build(BuildContext context) {
    final depends = AppDependsProvider.of(context);

    openWorkout() {
      Navigator.of(context)
          .pushNamed("workouts_menu/current_workout/", arguments: [workout, 0]);
    }

    void editCurrentWorkout(BuildContext context, WorkoutEntity workout) {
      if (depends.isConnection) {
        Navigator.of(context).pushNamed("/workouts_menu/create_workout/",
            arguments: [context, workout, true]);
      } else {
        showSnackBar(context, Strings.haventInternetConnetion);
      }
    }

    return GestureDetector(
      onTap: () => openWorkout(),
      child: Card(
        elevation: 2,
        shadowColor: Theme.of(context).cardColor,
        color: Theme.of(context).cardColor,
        child: Container(
          padding: EdgeInsets.only(
              right: Styles.base_margin_size_double,
              top: Styles.base_margin_size_double / 2,
              bottom: Styles.base_margin_size_double / 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 5,
              ),
              Image(
                image: const AssetImage(
                  "assets/images/workout_image.png",
                ),
                height: MediaQuery.sizeOf(context).height / 7,
                width: MediaQuery.sizeOf(context).height / 7,
              ),
              const Expanded(child: SizedBox()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    Styles.base_margin_size_double / 1.5,
                                vertical: Styles.base_margin_size_double / 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).focusColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              getDayOfWeekOnString(workout),
                              style: Styles.workout_text_style_week_day,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () =>
                                editCurrentWorkout(context, workout),
                            color: Theme.of(context).focusColor,
                            icon: const Icon(
                              Icons.mode_sharp,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () => showAdaptiveDialog(
                                context: context,
                                builder: (BuildContext newContext) {
                                  return _AreYouSureMenuWorkoutsDialog(
                                    depends: depends,
                                    index: index,
                                    previousContext: context,
                                  );
                                }),
                            color: Theme.of(context).focusColor,
                            icon: const Icon(
                              Icons.delete,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    truncateText(workout.title!, 10),
                    style: Styles.workout_text_style_dark_theme,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  NewWorkoutButton(
                      () => runCurrentWorkout(context),
                      Size(MediaQuery.sizeOf(context).width / 5,
                          MediaQuery.sizeOf(context).width / 10))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void runCurrentWorkout(
    BuildContext context,
  ) {
    Navigator.of(context)
        .pushNamed("workouts_menu/run_workout/", arguments: workout);
  }
}

class _AreYouSureMenuWorkoutsDialog extends StatelessWidget {
  const _AreYouSureMenuWorkoutsDialog(
      {required this.depends,
      required this.index,
      required this.previousContext});

  final AppDepends depends;
  final int index;
  final BuildContext previousContext;

  @override
  Widget build(BuildContext context) {
    Future<void> removeCurrentWorkout(
        WorkoutsRepository workoutsRepository, int index) async {
      final storage = depends.secureStorage;

      final tokenJson = await storage.read(dotenv.env['TOKEN_KEY']!);
      final tokenMap = jsonDecode(tokenJson);
      final token = tokenMap['access_token'];

      await workoutsRepository.deleteWorkout(index, token);
      previousContext.read<WorkoutsMenuBloc>().add(UpdateWorkoutEvent());
    }

    return AreYouSureDialog(
      onSubmit: () {
        if (depends.isConnection) {
          try {
            Navigator.of(context).pop();
            removeCurrentWorkout(depends.workoutsRepository, index);
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

String getDayOfWeekOnString(WorkoutEntity workout, {bool isFullText = false}) {
  final List<String> shortNames = [
    Strings.mon,
    Strings.tue,
    Strings.wed,
    Strings.thur,
    Strings.fri,
    Strings.sat,
    Strings.sun,
  ];

  final List<String> fullNames = [
    Strings.monday,
    Strings.tuesday,
    Strings.wednesday,
    Strings.thursday,
    Strings.friday,
    Strings.saturday,
    Strings.sunday,
  ];

  if (workout.weekday < 1 || workout.weekday > 7) return "--";

  return isFullText
      ? fullNames[workout.weekday - 1]
      : shortNames[workout.weekday - 1];
}
