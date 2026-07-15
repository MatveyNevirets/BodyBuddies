// lib/features/workouts/presentation/running_workout/presentation/exercise_screen.dart
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/presentation/bloc/running_workout_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/presentation/workout_screen.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/workout_ticker/workout_ticker.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseScreen extends StatelessWidget {
  final ExerciseEntity exercise;
  final WorkoutEntity journalWorkout;
  final WorkoutTicker ticker;
  final RunningWorkoutState state;
  int workoutTimerDuration; // можно менять, т.к. это поле

  final TextEditingController repsController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  ExerciseScreen(
    this.exercise,
    this.ticker,
    this.workoutTimerDuration,
    this.state,
    this.journalWorkout, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkTheme.background,
      body: Stack(
        children: [
          // Геометрический фон (асимметричные фигуры с низкой прозрачностью)
          const Positioned.fill(
            child: _GeometricBackground(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  // Заголовок экрана (небольшой, строгий)
                  Text(
                    "Тренировка", // предположим, есть ключ "training" = "Тренировка"
                    style: DarkTheme.appbar_text_style.copyWith(
                      color: DarkTheme.secondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Плитка с таймером и сетами
                  _TimerAndSetsPanel(
                    ticker: ticker,
                    workoutTimerDuration: workoutTimerDuration,
                    onTick: (newDuration) {
                      workoutTimerDuration = newDuration;
                    },
                    exercise: exercise,
                  ),
                  const SizedBox(height: 20),
                  // Название упражнения
                  Text(
                    exercise.title,
                    style: DarkTheme.workout_text_style_background_24.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 26,
                      color: DarkTheme.primary,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Блок ввода веса и повторений
                  _InputFields(
                    weightController: weightController,
                    repsController: repsController,
                    exercise: exercise,
                  ),
                  const Spacer(),
                  // Кнопка "Готово"
                  BaseButton(
                    onClick: () => nextOnExercisesList(
                      context,
                      workoutTimerDuration,
                      journalWorkout,
                    ),
                    buttonText: Strings.done,
                    icon: Icons.check_rounded,
                    isElevated: true,
                    backgroundColor: DarkTheme.primary,
                    color: DarkTheme.background,
                    radius: 14,
                    buttonSize: const Size(double.infinity, 56),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void nextOnExercisesList(
    BuildContext context,
    int duration,
    WorkoutEntity journalWorkout,
  ) {
    double weight;
    int reps;

    if (weightController.text.isEmpty) {
      weight = exercise.kilograms;
    } else {
      weight = double.parse(weightController.text);
    }

    if (repsController.text.isEmpty) {
      reps = exercise.reps;
    } else {
      reps = int.parse(repsController.text);
    }

    final exerciseEntity = ExerciseEntity(
      title: exercise.title,
      sets: exercise.sets,
      reps: reps,
      kilograms: weight,
      isExercise: exercise.isExercise,
      isTimerExercise: exercise.isTimerExercise,
      restTimeInMinutes: exercise.restTimeInMinutes,
      restTimeInSeconds: exercise.restTimeInSeconds,
      timerTimeMinutes: exercise.timerTimeMinutes,
      timerTimeSeconds: exercise.timerTimeSeconds,
    );

    journalWorkout.exercises.add(exerciseEntity);

    if (state.exercises.last == exercise &&
        state.exercises.last.currentSets == exercise.sets) {
      DateTime currentData = DateTime.now();
      String dataInFormat =
          "${currentData.day.toString().padLeft(2, "0")}.${currentData.month.toString().padLeft(2, "0")}.${currentData.year}";

      journalWorkout.duration = getTime(workoutTimerDuration);
      journalWorkout.date = dataInFormat;

      context
          .read<RunningWorkoutBloc>()
          .add(WorkoutCompleteEvent(workoutTimerDuration, journalWorkout));
    } else {
      context
          .read<RunningWorkoutBloc>()
          .add(ExerciseRestEvent(workoutTimerDuration));
    }
  }
}

// Виджет таймера и сетов
class _TimerAndSetsPanel extends StatelessWidget {
  final WorkoutTicker ticker;
  final int workoutTimerDuration;
  final ValueChanged<int> onTick;
  final ExerciseEntity exercise;

  const _TimerAndSetsPanel({
    required this.ticker,
    required this.workoutTimerDuration,
    required this.onTick,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: DarkTheme.divider, width: 1),
      ),
      child: Row(
        children: [
          // Таймер
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.time,
                  style: const TextStyle(
                    color: DarkTheme.secondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                StreamBuilder<int>(
                  stream: ticker.workoutTick(workoutTimerDuration),
                  builder: (context, snapshot) {
                    final int currentDuration;
                    if (snapshot.hasData) {
                      currentDuration = snapshot.data!;
                      // обновляем родительскую переменную
                      onTick(currentDuration);
                    } else {
                      currentDuration = workoutTimerDuration;
                    }
                    return Text(
                      getTime(currentDuration),
                      style: const TextStyle(
                        color: DarkTheme.primary,
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                        height: 1,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Сеты
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                Strings.sets,
                style: const TextStyle(
                  color: DarkTheme.secondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: DarkTheme.backgroundSecondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${exercise.currentSets} | ${exercise.sets}",
                  style: const TextStyle(
                    color: DarkTheme.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Поля ввода веса и повторений
class _InputFields extends StatelessWidget {
  final TextEditingController weightController;
  final TextEditingController repsController;
  final ExerciseEntity exercise;

  const _InputFields({
    required this.weightController,
    required this.repsController,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _InputTile(
            label: Strings.weight,
            controller: weightController,
            hint: exercise.kilograms == exercise.kilograms.toInt()
                ? exercise.kilograms.toInt().toString()
                : exercise.kilograms.toString(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _InputTile(
            label: Strings.rep,
            controller: repsController,
            hint: exercise.reps.toString(),
          ),
        ),
      ],
    );
  }
}

// Одно поле ввода
class _InputTile extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;

  const _InputTile({
    required this.label,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: DarkTheme.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: DarkTheme.secondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: DarkTheme.body_text_style.copyWith(
              color: DarkTheme.primary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            cursorColor: DarkTheme.primary,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              filled: true,
              fillColor: DarkTheme.backgroundSecondary,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: DarkTheme.primary,
                  width: 1.5,
                ),
              ),
              hintText: hint,
              hintStyle: DarkTheme.hint_text_style_create_workout.copyWith(
                color: DarkTheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Геометрический фон (переиспользуемый, как на других экранах)
class _GeometricBackground extends StatelessWidget {
  const _GeometricBackground();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          top: -50,
          right: -40,
          child: _GeoShape(
            width: 200,
            height: 200,
            rotation: 0.5,
            color: _geoColor,
            shape: _GeoShapeType.triangle,
          ),
        ),
        Positioned(
          top: 150,
          left: -30,
          child: _GeoShape(
            width: 220,
            height: 40,
            rotation: -0.25,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: 120,
          right: -20,
          child: _GeoShape(
            width: 180,
            height: 50,
            rotation: -0.55,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: -30,
          left: -15,
          child: _GeoShape(
            width: 160,
            height: 160,
            rotation: -0.7,
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
