// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/widgets/new_workout_button.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/workout_create_screen.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/colors/colors.dart';
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
    final workoutsRepository =
        AppDependsProvider.of(context).workoutsRepository;

    openWorkout() {
      Navigator.of(context)
          .pushNamed("workouts_menu/current_workout/", arguments: [workout, 0]);
    }

    return GestureDetector(
      onTap: () => openWorkout(),
      child: Card(
        color: Colours.workout_card_background_color,
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
                  "lib/assets/images/workout_image.png",
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
                                color: Colours.workoutCardForegroundColor,
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
                            color: Colours.workoutCardForegroundColor,
                            icon: const Icon(
                              Icons.mode_sharp,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () => removeCurrentWorkout(
                                context, workoutsRepository, index),
                            color: Colours.workoutCardForegroundColor,
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
                    style: Styles.workout_text_style,
                  ),
                  Text(
                    truncateText(getMusclesGroupOnString(), 20),
                    style: Styles.workout_text_style2,
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

  void editCurrentWorkout(BuildContext context, WorkoutEntity workout) {
    Navigator.of(context).pushNamed("/workouts_menu/create_workout/",
        arguments: [context, workout, true]);
  }

  void removeCurrentWorkout(
      BuildContext context, WorkoutsRepository workoutsRepository, int index) {
    workoutsRepository.deleteWorkout(index);
    Navigator.pushReplacementNamed(context, "/workouts_menu");
  }

  void runCurrentWorkout(
    BuildContext context,
  ) {
    Navigator.of(context)
        .pushNamed("workouts_menu/run_workout/", arguments: workout);
  }

  String getMusclesGroupOnString() {
    List<String> groups = [];

    if (workout.abs) groups.add(Strings.abs);
    if (workout.forearms) groups.add(Strings.forearms);
    if (workout.biceps) groups.add(Strings.biceps);
    if (workout.back) groups.add(Strings.back);
    if (workout.chest) groups.add(Strings.chest);
    if (workout.triceps) groups.add(Strings.triceps);
    if (workout.shoulders) groups.add(Strings.shoulders);
    if (workout.cardio) groups.add(Strings.cardio);
    if (workout.legs) groups.add(Strings.legs);

    return groups.toString().substring(1, groups.toString().length - 1);
  }
}

String getDayOfWeekOnString(WorkoutEntity workout) {
  if (workout.weekday == 1) {
    return Strings.mon;
  } else if (workout.weekday == 2) {
    return Strings.tue;
  } else if (workout.weekday == 3) {
    return Strings.wed;
  } else if (workout.weekday == 4) {
    return Strings.thur;
  } else if (workout.weekday == 5) {
    return Strings.fri;
  } else if (workout.weekday == 6) {
    return Strings.sat;
  } else if (workout.weekday == 7) {
    return Strings.sun;
  } else {
    return Strings.empty;
  }
}
