// lib/features/workouts/presentation/workout_feature_card/presentation/workouts_feature_card.dart
import 'dart:convert';

import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WorkoutFeatureCard extends StatefulWidget {
  const WorkoutFeatureCard(
      {super.key,
      required this.workoutsRepository,
      required this.secureStorage});

  final WorkoutsRepository workoutsRepository;
  final SecureStorage secureStorage;

  @override
  State<WorkoutFeatureCard> createState() => _WorkoutFeatureCardState();
}

class _WorkoutFeatureCardState extends State<WorkoutFeatureCard> {
  late Future<WorkoutEntity?> _todayWorkoutFuture;
  bool _initialized = false;

  static const Color _surface = Color(0xFF0E1D2D);
  static const Color _surface2 = Color(0xFF12263A);
  static const Color _border = Color(0xFF244055);
  static const Color _primary = Color(0xFF2F80ED);
  static const Color _textMain = Color(0xFFF5F8FC);
  static const Color _textSecondary = Color(0xFF9BB0C5);
  static const Color _accent = Color(0xFFB8D9FF);

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
              borderRadius: BorderRadius.circular(28),
              child: Container(
                height: 218,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_surface, _surface2],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: _border, width: 1),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xAA04101A),
                      blurRadius: 22,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          "assets/images/WorkoutsCardBackground.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF07131F).withOpacity(0.18),
                                const Color(0xFF07131F).withOpacity(0.64),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: -26,
                        top: -18,
                        child: _CardShape(
                          size: 128,
                          color: _primary.withOpacity(0.16),
                        ),
                      ),
                      Positioned(
                        left: -12,
                        bottom: -26,
                        child: _CardShape(
                          size: 92,
                          color: _accent.withOpacity(0.08),
                        ),
                      ),
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
                                      _LabelChip(
                                        label: 'ТРЕНИРОВКА ДНЯ',
                                        fill: _primary.withOpacity(0.14),
                                        border: _primary.withOpacity(0.46),
                                        textColor: _accent,
                                      ),
                                      const SizedBox(height: 14),
                                      if (isLoading)
                                        const _LoadingTitle()
                                      else
                                        Text(
                                          title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: _textMain,
                                            fontSize: 25,
                                            height: 1.06,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: -0.6,
                                          ),
                                        ),
                                      const SizedBox(height: 10),
                                      Text(
                                        dayLabel,
                                        style: const TextStyle(
                                          color: _textSecondary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _DateBadge(date: dateLabel),
                                    const SizedBox(height: 22),
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
                            const Row(
                              children: [
                                _MetaChip(
                                  icon: Icons.fitness_center_rounded,
                                  label: 'Открыть план',
                                ),
                                SizedBox(width: 10),
                                _MetaChip(
                                  icon: Icons.play_circle_rounded,
                                  label: 'Старт одним касанием',
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
      height: 58,
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Center(
        child: CupertinoActivityIndicator(
          radius: 11,
          color: Color(0xFFF5F8FC),
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
      color: const Color(0xFF2F80ED).withOpacity(0.18),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: loading ? null : onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border:
                Border.all(color: const Color(0xFF4A9BFF).withOpacity(0.35)),
          ),
          child: loading
              ? const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CupertinoActivityIndicator(
                      radius: 10,
                      color: Color(0xFFF5F8FC),
                    ),
                  ),
                )
              : const Icon(
                  Icons.play_arrow_rounded,
                  color: Color(0xFFF5F8FC),
                  size: 30,
                ),
        ),
      ),
    );
  }
}

class _LabelChip extends StatelessWidget {
  final String label;
  final Color fill;
  final Color border;
  final Color textColor;

  const _LabelChip({
    required this.label,
    required this.fill,
    required this.border,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: border, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.9,
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFFB8D9FF)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFF5F8FC),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DateBadge extends StatelessWidget {
  final String date;

  const _DateBadge({required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'TODAY',
            style: TextStyle(
              color: Color(0xFF7EA8D8),
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: const TextStyle(
              color: Color(0xFFF5F8FC),
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _CardShape extends StatelessWidget {
  final double size;
  final Color color;

  const _CardShape({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
