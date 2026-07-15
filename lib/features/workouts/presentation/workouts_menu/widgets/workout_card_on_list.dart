// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';

import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/core/widgets/are_you_sure_dialog.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/workout_create_screen.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/presentation/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WorkoutCardOnList extends StatelessWidget {
  final WorkoutEntity workout;
  final int index;
  final BuildContext workoutMenuContext;
  final SecureStorage secureStorage;
  final WorkoutsRepository workoutsRepository;
  final bool isConnection;

  const WorkoutCardOnList({
    super.key,
    required this.workoutMenuContext,
    required this.workout,
    required this.index,
    required this.isConnection,
    required this.secureStorage,
    required this.workoutsRepository,
  });

  @override
  Widget build(BuildContext context) {
    void openWorkout() {
      Navigator.of(context).pushNamed(
        "workouts_menu/current_workout/",
        arguments: [workout, 0],
      );
    }

    void editCurrentWorkout() {
      if (isConnection) {
        Navigator.of(context).pushNamed(
          "/workouts_menu/create_workout/",
          arguments: [context, workout, true],
        );
      } else {
        showSnackBar(context, Strings.haventInternetConnetion);
      }
    }

    void runCurrentWorkout() {
      Navigator.of(context).pushNamed(
        "workouts_menu/run_workout/",
        arguments: workout,
      );
    }

    return GestureDetector(
      onTap: openWorkout,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: DarkTheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: DarkTheme.divider, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Верхняя строка: день недели + кнопки редактирования/удаления
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: DarkTheme.backgroundSecondary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    getDayOfWeekOnString(workout),
                    style: DarkTheme.workout_text_style_week_day.copyWith(
                      color: DarkTheme.secondary,
                    ),
                  ),
                ),
                Row(
                  children: [
                    _IconButton(
                      icon: Icons.edit_outlined,
                      onTap: editCurrentWorkout,
                    ),
                    const SizedBox(width: 4),
                    _IconButton(
                      icon: Icons.delete_outline_rounded,
                      onTap: () => showAdaptiveDialog(
                        context: context,
                        builder: (_) => _AreYouSureMenuWorkoutsDialog(
                          index: index,
                          secureStorage: secureStorage,
                          isConnection: isConnection,
                          previousContext: context,
                          workoutsRepository: workoutsRepository,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Название тренировки
            Text(
              truncateText(workout.title!, 20),
              style: DarkTheme.workout_text_style_dark_theme.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: DarkTheme.primary,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16),
            // Кнопка «Старт» с иконкой play
            BaseButton(
              onClick: runCurrentWorkout,
              buttonText:
                  Strings.start, // предполагается, что есть ключ "start"
              icon: Icons.play_arrow_rounded,
              isElevated: true,
              backgroundColor: DarkTheme.primary,
              color: DarkTheme.background,
              radius: 14,
              buttonSize: const Size(double.infinity, 48),
            ),
          ],
        ),
      ),
    );
  }
}

// Мини‑кнопка (edit / delete) без лишних обводок
class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          size: 20,
          color: DarkTheme.secondary,
        ),
      ),
    );
  }
}

// Диалог подтверждения удаления (без изменений логики)
class _AreYouSureMenuWorkoutsDialog extends StatelessWidget {
  const _AreYouSureMenuWorkoutsDialog({
    required this.isConnection,
    required this.index,
    required this.previousContext,
    required this.secureStorage,
    required this.workoutsRepository,
  });

  final bool isConnection;
  final int index;
  final BuildContext previousContext;
  final SecureStorage secureStorage;
  final WorkoutsRepository workoutsRepository;

  @override
  Widget build(BuildContext context) {
    Future<void> removeCurrentWorkout(
        WorkoutsRepository workoutsRepository, int index) async {
      final tokenJson = await secureStorage.read(dotenv.env['TOKEN_KEY']!);
      final tokenMap = jsonDecode(tokenJson);
      final token = tokenMap['access_token'];

      await workoutsRepository.deleteWorkout(index, token);
      previousContext.read<WorkoutsMenuBloc>().add(UpdateWorkoutEvent());
    }

    return AreYouSureDialog(
      onSubmit: () {
        if (isConnection) {
          try {
            Navigator.of(context).pop();
            removeCurrentWorkout(workoutsRepository, index);
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

// Вспомогательная функция дня недели (без изменений)
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
