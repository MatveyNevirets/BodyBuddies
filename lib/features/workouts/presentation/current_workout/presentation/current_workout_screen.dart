import 'dart:ui' as ui;

import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/presentation/workout_screen.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/workout_create_screen.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:flutter/material.dart';

class WorkoutEntityScreen extends StatelessWidget {
  const WorkoutEntityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    final WorkoutEntity workoutEntity = args[0] as WorkoutEntity;
    // final int whatsOpen = args[1] as int;

    return Scaffold(
      backgroundColor: DarkTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8, top: 8),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Center(
              child: Icon(
                Icons.arrow_back_rounded,
                color: DarkTheme.primary,
                size: 20,
              ),
            ),
          ),
        ),
        centerTitle: false,
        titleSpacing: 8,
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: _GeometricBackground(),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: DarkTheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: DarkTheme.divider, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Заголовок тренировки (уже в appBar, но можно дублировать для акцента)
                    if (workoutEntity.title.toString().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            decoration: BoxDecoration(
                              color: DarkTheme.backgroundSecondary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              workoutEntity.title.toString(),
                              textAlign: TextAlign.center,
                              style: DarkTheme.workout_text_style_background_24
                                  .copyWith(
                                color: DarkTheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Список упражнений
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: workoutEntity.exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = workoutEntity.exercises[index];
                        if (exercise.isExercise) {
                          return _ExerciseCard(
                            title: exercise.title,
                            isTimer: false,
                            children: [
                              buildRepsSetsFields(workoutEntity, index),
                              const SizedBox(height: 8),
                              buildRestWeightFields(workoutEntity, index),
                            ],
                          );
                        } else if (exercise.isTimerExercise) {
                          return _ExerciseCard(
                            title: exercise.title,
                            isTimer: true,
                            children: [
                              buildExerciseTimeSets(workoutEntity, index),
                              const SizedBox(height: 8),
                              buildWeightRestTime(workoutEntity, index),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Вспомогательные методы для полей упражнений ---

  Row buildExerciseTimeSets(WorkoutEntity workoutEntity, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _DataChip(
            label: Strings.time,
            value: getTime(
                workoutEntity.exercises[index].timerTimeMinutes * 60 +
                    workoutEntity.exercises[index].timerTimeSeconds,
                needHourses: false),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _DataChip(
            label: Strings.sets,
            value: workoutEntity.exercises[index].sets.toString(),
          ),
        ),
      ],
    );
  }

  Row buildWeightRestTime(WorkoutEntity workoutEntity, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: _DataChip(
            label: Strings.weight,
            value: workoutEntity.exercises[index].kilograms ==
                    workoutEntity.exercises[index].kilograms.toInt()
                ? workoutEntity.exercises[index].kilograms.toInt().toString()
                : workoutEntity.exercises[index].kilograms.toString(),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 4,
          child: _DataChip(
            label: Strings.rest,
            value: getTime(
                workoutEntity.exercises[index].restTimeInMinutes * 60 +
                    workoutEntity.exercises[index].restTimeInSeconds,
                needHourses: false),
          ),
        ),
      ],
    );
  }

  Row buildRestWeightFields(WorkoutEntity workoutEntity, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: _DataChip(
            label: Strings.rest,
            value: getTime(
                workoutEntity.exercises[index].restTimeInMinutes * 60 +
                    workoutEntity.exercises[index].restTimeInSeconds,
                needHourses: false),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: _DataChip(
            label: Strings.weight,
            value: workoutEntity.exercises[index].kilograms ==
                    workoutEntity.exercises[index].kilograms.toInt()
                ? workoutEntity.exercises[index].kilograms.toInt().toString()
                : workoutEntity.exercises[index].kilograms.toString(),
          ),
        ),
      ],
    );
  }

  Row buildRepsSetsFields(WorkoutEntity workoutEntity, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _DataChip(
            label: Strings.repeats,
            value: workoutEntity.exercises[index].reps.toString(),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _DataChip(
            label: Strings.sets,
            value: workoutEntity.exercises[index].sets.toString(),
          ),
        ),
      ],
    );
  }
}

// --- Виджет карточки упражнения ---
class _ExerciseCard extends StatelessWidget {
  final String title;
  final bool isTimer;
  final List<Widget> children;

  const _ExerciseCard({
    required this.title,
    required this.isTimer,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: DarkTheme.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DarkTheme.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isTimer ? Icons.timer_outlined : Icons.fitness_center_rounded,
                size: 16,
                color: DarkTheme.secondary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  truncateText(title, 20),
                  style: DarkTheme.body_text_style.copyWith(
                    fontWeight: FontWeight.w700,
                    color: DarkTheme.primary,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

// --- Микровиджет для пары "лейбл : значение" ---
class _DataChip extends StatelessWidget {
  final String label;
  final String value;

  const _DataChip({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: DarkTheme.divider, width: 1),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: DarkTheme.mini_current_card_text2.copyWith(
              color: DarkTheme.secondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: DarkTheme.backgroundSecondary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: DarkTheme.mini_current_card_text.copyWith(
                color: DarkTheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Геометрический фон ---
class _GeometricBackground extends StatelessWidget {
  const _GeometricBackground();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          top: -30,
          right: -30,
          child: _GeoShape(
            width: 150,
            height: 150,
            rotation: 0.45,
            color: _geoColor,
            shape: _GeoShapeType.triangle,
          ),
        ),
        Positioned(
          top: 200,
          left: -20,
          child: _GeoShape(
            width: 180,
            height: 30,
            rotation: -0.3,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: 120,
          right: -25,
          child: _GeoShape(
            width: 160,
            height: 45,
            rotation: -0.55,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: -30,
          left: -10,
          child: _GeoShape(
            width: 140,
            height: 140,
            rotation: -0.65,
            color: _geoColor,
            shape: _GeoShapeType.triangle,
          ),
        ),
      ],
    );
  }

  static const Color _geoColor = DarkTheme.primary;
}

enum _GeoShapeType { triangle, rectangle }

class _GeoShape extends StatelessWidget {
  final double width;
  final double height;
  final double rotation;
  final Color color;
  final _GeoShapeType shape;

  const _GeoShape({
    required this.width,
    required this.height,
    required this.rotation,
    required this.color,
    required this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Opacity(
        opacity: 0.05,
        child: shape == _GeoShapeType.triangle
            ? CustomPaint(
                size: Size(width, height),
                painter: _TrianglePainter(color),
              )
            : Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
