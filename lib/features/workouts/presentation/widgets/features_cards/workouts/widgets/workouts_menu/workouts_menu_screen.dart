// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/home/presentation/widgets/body_home_data.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_card_on_list.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/add_card_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../core/strings/strings.dart';

class WorkoutsMenuScreen extends StatelessWidget {
  late final BodyHomeData mainFrontendData;

  WorkoutsMenuScreen({super.key, required this.mainFrontendData});

  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    createWorkout() {
      Navigator.of(context).pushNamed(
        "/workouts_menu/create_workout/",
        arguments: [
          context,
          [],
          false,
        ],
      );
    }

    return BlocBuilder<WorkoutsMenuBloc, WorkoutsMenuState>(
      builder: (context, state) {
        return Scaffold(
          appBar: mainFrontendData.createAppBarWidget(
              appbarTitle: Strings.workouts_appbar),
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
                itemCount: state.database.fakeWorkoutEntities.length + 1,
                itemBuilder: (context, index) {
                  return index == 0
                      ? OpenWorkoutsJournal()
                      : WorkoutCardOnList(
                          workoutMenuContext: context,
                          workout: state.database.getWorkout(index - 1),
                          fakeWorkoutsDatabase: state.database,
                        );
                }),
          ),
        );
      },
      buildWhen: (prev, curr) =>
          curr is AddWorkoutState || curr is UpdateWorkoutState,
    );
  }
}
