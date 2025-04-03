// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/widgets/open_journal_card.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/widgets/workout_card_on_list.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/material.dart';

class WorkoutsMenuScreen extends StatefulWidget {
  const WorkoutsMenuScreen({super.key});

  @override
  State<WorkoutsMenuScreen> createState() => _WorkoutsMenuScreenState();
}

class _WorkoutsMenuScreenState extends State<WorkoutsMenuScreen> {
  @override
  Widget build(BuildContext context) {
    Future<List<WorkoutEntity>>? workouts;

    final workoutsRepository =
        AppDependsProvider.of(context).workoutsRepository;

    setState(() {
      workouts = workoutsRepository.fetchAllWorkout(context);
    });

    createWorkout() {
      Navigator.of(context).pushNamed(
        "/workouts_menu/create_workout/",
        arguments: [
          context,
          WorkoutEntity(title: "title", exercises: []),
          false,
        ],
      );
      setState(() {
        workouts = workoutsRepository.fetchAllWorkout(context);
      });
    }

    setState(() {});

    return FutureBuilder(
        future: workouts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: createAppBarWidget(
                  appbarTitle: Strings.workouts_appbar, context: context),
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
              body: Container(
                margin: Styles.base_margin_size,
                child: ListView.builder(
                  itemCount: snapshot.data!.length + 1,
                  itemBuilder: (context, index) {
                    return index == 0
                        ? OpenWorkoutsJournal()
                        : WorkoutCardOnList(
                            workoutMenuContext: context,
                            workout: snapshot.data!.elementAt(index - 1),
                            index: index - 1,
                          );
                  },
                ),
              ),
            );
          } else if (snapshot.hasError) {
            log("Error in future builder workouts repository, error: ${snapshot.hasError}");
            throw Exception(
                "Workouts repository snapshot error: ${snapshot.error}");
          }
          return const LoadingScreen();
        });
  }
}
