// lib/features/workouts/presentation/workout_feature_card/presentation/workouts_feature_card.dart
import 'dart:convert';

import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WorkoutFeatureCard extends StatefulWidget {
  const WorkoutFeatureCard({
    super.key,
    required this.workoutsRepository,
    required this.secureStorage,
  });

  final WorkoutsRepository workoutsRepository;
  final SecureStorage secureStorage;

  @override
  State<WorkoutFeatureCard> createState() => _WorkoutFeatureCardState();
}

class _WorkoutFeatureCardState extends State<WorkoutFeatureCard> {
  late Future<WorkoutEntity?> _todayWorkoutFuture;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _todayWorkoutFuture = getTodayWorkout();
      _initialized = true;
    }
  }

  Future<WorkoutEntity?> getTodayWorkout() async {
    try {
      final tokenJson =
          await widget.secureStorage.read(dotenv.env['TOKEN_KEY']!);

      final tokenMap = jsonDecode(tokenJson) as Map<String, dynamic>;
      final token = tokenMap['access_token'];

      final thisWeekDay = DateTime.now().weekday;
      final workoutsList =
          await widget.workoutsRepository.fetchAllWorkout(token);

      if (workoutsList == null) return null;

      for (final workout in workoutsList) {
        if (workout.weekday == thisWeekDay) {
          return workout;
        }
      }

      if (workoutsList.isNotEmpty) {
        return workoutsList.first;
      }

      throw Exception('Workout list is empty');
    } catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }

  void runCurrentWorkout(BuildContext context, WorkoutEntity workout) {
    Navigator.of(context).pushNamed(
      "workouts_menu/run_workout/",
      arguments: workout,
    );
  }

  void openWorkoutsMenuScreen() {
    Navigator.of(context).pushNamed("/workouts_menu");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WorkoutEntity?>(
      future: _todayWorkoutFuture,
      builder: (context, snapshot) {
        final hasData = snapshot.hasData;
        final workout = snapshot.data;

        final title =
            hasData ? _shorten(workout!.title.toString(), 28) : Strings.empty;
        final dayLabel =
            hasData ? _weekdayLabel(workout!.weekday) : 'Подборка на сегодня';
        final dateLabel = _getDate();
        final isLoading = snapshot.connectionState == ConnectionState.waiting;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: openWorkoutsMenuScreen,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                height: 218,
                decoration: BoxDecoration(
                  color: DarkTheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: DarkTheme.divider,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Фоновое изображение с затемнением
                      Image.asset(
                        "assets/images/WorkoutsCardBackground.png",
                        fit: BoxFit.cover,
                      ),
                      // Затемняющий слой для читаемости текста
                      Container(
                        color: DarkTheme.background.withOpacity(0.55),
                      ),
                      // Геометрическая фигура (асимметричная, приглушённая)
                      Positioned(
                        right: -40,
                        top: -40,
                        child: Transform.rotate(
                          angle: 0.4,
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              color: DarkTheme.primary.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      ),
                      // Основной контент
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Метка "ТРЕНИРОВКА ДНЯ" – просто текст
                                      const Text(
                                        'ТРЕНИРОВКА ДНЯ',
                                        style: TextStyle(
                                          color: DarkTheme.secondary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      if (isLoading)
                                        const _LoadingTitle()
                                      else
                                        Text(
                                          title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: DarkTheme.workout_text_style
                                              .copyWith(
                                            fontSize: 24,
                                            height: 1.1,
                                          ),
                                        ),
                                      const SizedBox(height: 8),
                                      Text(
                                        dayLabel,
                                        style: const TextStyle(
                                          color: DarkTheme.secondary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // Дата
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: DarkTheme.background
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: DarkTheme.divider,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'TODAY',
                                            style: TextStyle(
                                              color: DarkTheme.secondary,
                                              fontSize: 8.5,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 1.0,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            dateLabel,
                                            style: const TextStyle(
                                              color: DarkTheme.primary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    // Кнопка воспроизведения
                                    _PlayButton(
                                      loading: isLoading,
                                      onTap: () {
                                        if (workout != null) {
                                          runCurrentWorkout(context, workout);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            // Нижние метки – теперь без иконок и не вылезают
                            const Row(
                              children: [
                                Flexible(
                                  child: _MetaChip(label: 'Открыть план'),
                                ),
                                SizedBox(width: 8),
                                Flexible(
                                  child:
                                      _MetaChip(label: 'Старт одним касанием'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getDate() {
    final day = DateTime.now().day.toString().padLeft(2, '0');
    final month = DateTime.now().month.toString().padLeft(2, '0');
    return '$day.$month';
  }

  String _shorten(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength - 1)}…';
  }

  String _weekdayLabel(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Понедельник';
      case DateTime.tuesday:
        return 'Вторник';
      case DateTime.wednesday:
        return 'Среда';
      case DateTime.thursday:
        return 'Четверг';
      case DateTime.friday:
        return 'Пятница';
      case DateTime.saturday:
        return 'Суббота';
      case DateTime.sunday:
        return 'Воскресенье';
      default:
        return 'Сегодня';
    }
  }
}

class _LoadingTitle extends StatelessWidget {
  const _LoadingTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: 160,
      decoration: BoxDecoration(
        color: DarkTheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CupertinoActivityIndicator(
          radius: 10,
          color: DarkTheme.primary,
        ),
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onTap;

  const _PlayButton({
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: DarkTheme.primary.withOpacity(0.12),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: loading ? null : onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: DarkTheme.primary.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: loading
              ? const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CupertinoActivityIndicator(
                      radius: 10,
                      color: DarkTheme.primary,
                    ),
                  ),
                )
              : const Icon(
                  Icons.play_arrow_rounded,
                  color: DarkTheme.primary,
                  size: 28,
                ),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final String label;

  const _MetaChip({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: DarkTheme.background.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: DarkTheme.divider,
          width: 1,
        ),
      ),
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(
          color: DarkTheme.secondary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
      ),
    );
  }
}
