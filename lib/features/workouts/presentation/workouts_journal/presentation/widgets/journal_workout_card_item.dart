import 'dart:convert';

import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/are_you_sure_dialog.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/workout_create_screen.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/presentation/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:body_buddies/internal/application/di/app_depends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/colors/colors.dart';

class JournalWorkoutCardItem extends StatelessWidget {
  WorkoutEntity workout;
  final VoidCallback removeItem;

  JournalWorkoutCardItem(this.workout, {super.key, required this.removeItem});

  @override
  Widget build(BuildContext context) {
    void openCurrentWorkout() {
      Navigator.of(context)
          .pushNamed("workouts_menu/current_workout/", arguments: [workout, 1]);
    }

    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () => openCurrentWorkout(),
        child: Card(
          color: Colours.workoutCardForegroundColor,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      truncateText(workout.title.toString(), 14),
                      style: Styles.mini_journal_card_text,
                    ),
                    Text(
                      "Длительность:",
                      style: Styles.mini_journal_card_text,
                    ),
                    Text(
                      workout.duration.isNotEmpty
                          ? workout.duration.toString()
                          : "00:00:00",
                      style: Styles.mini_journal_card_text,
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      workout.date,
                      style: Styles.mini_journal_card_text,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => removeItem.call(),
                      child: const Icon(
                        Icons.delete,
                        color: Colours.workout_card_background_color,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
