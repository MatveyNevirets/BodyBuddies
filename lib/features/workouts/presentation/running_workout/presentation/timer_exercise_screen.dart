// lib/features/workouts/presentation/running_workout/presentation/timer_exercise_screen.dart
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/presentation/workout_screen.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/workout_ticker/reverse_ticker.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/workout_ticker/workout_ticker.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/running_workout_bloc.dart';

class TimerExerciseScreen extends StatelessWidget {
  final ExerciseEntity exercise;
  final WorkoutTicker ticker;
  final int workoutTimerDuration;
  final RunningWorkoutState state;
  final WorkoutEntity journalWorkout;

  final ReverseTicker reverseTicker = ReverseTicker();
  final TextEditingController weightController = TextEditingController();

  TimerExerciseScreen(
    this.exercise,
    this.ticker,
    this.workoutTimerDuration,
    this.state,
    this.journalWorkout, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int exerciseDuration =
        exercise.timerTimeMinutes * 60 + exercise.timerTimeSeconds;

    return Scaffold(
      backgroundColor: DarkTheme.background,
      body: Stack(
        children: [
          // Асимметричные геометрические фигуры на фоне
          const Positioned.fill(
            child: _ExerciseBackground(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  // Верхняя панель: общее время тренировки и сеты
                  _TopInfoBar(
                    ticker: ticker,
                    workoutDuration: workoutTimerDuration,
                    currentSet: exercise.currentSets,
                    totalSets: exercise.sets,
                  ),
                  const SizedBox(height: 24),
                  // Огромный обратный отсчёт упражнения
                  Expanded(
                    child: _CountdownHero(
                      duration: exerciseDuration,
                      reverseTicker: reverseTicker,
                      onFinished: () => nextOnExercisesList(context),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Поле ввода веса
                  _WeightInputField(
                    controller: weightController,
                    hint: exercise.kilograms == exercise.kilograms.toInt()
                        ? exercise.kilograms.toInt().toString()
                        : exercise.kilograms.toString(),
                  ),
                  const SizedBox(height: 20),
                  // Кнопка "Готово" (полноширинная)
                  BaseButton(
                    onClick: () => nextOnExercisesList(context),
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

  void nextOnExercisesList(BuildContext context) {
    double weight = weightController.text.isEmpty
        ? exercise.kilograms
        : double.parse(weightController.text);

    final ExerciseEntity updatedExercise = ExerciseEntity(
      title: exercise.title,
      sets: exercise.sets,
      kilograms: weight,
      isExercise: exercise.isExercise,
      isTimerExercise: exercise.isTimerExercise,
      restTimeInMinutes: exercise.restTimeInMinutes,
      restTimeInSeconds: exercise.restTimeInSeconds,
      timerTimeMinutes: exercise.timerTimeMinutes,
      timerTimeSeconds: exercise.timerTimeSeconds,
    );

    journalWorkout.exercises.add(updatedExercise);

    if (state.exercises.last == exercise &&
        state.exercises.last.currentSets == exercise.sets) {
      // Завершение всей тренировки
      final now = DateTime.now();
      final dateStr =
          "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}";
      journalWorkout.duration = getTime(workoutTimerDuration);
      journalWorkout.date = dateStr;

      context
          .read<RunningWorkoutBloc>()
          .add(WorkoutCompleteEvent(workoutTimerDuration, journalWorkout));
    } else {
      // Переход к отдыху
      context
          .read<RunningWorkoutBloc>()
          .add(ExerciseRestEvent(workoutTimerDuration));
    }
  }
}

// Верхняя панель: общее время тренировки слева, сеты справа
class _TopInfoBar extends StatelessWidget {
  final WorkoutTicker ticker;
  final int workoutDuration;
  final int currentSet;
  final int totalSets;

  const _TopInfoBar({
    required this.ticker,
    required this.workoutDuration,
    required this.currentSet,
    required this.totalSets,
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
          // Общий таймер тренировки
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Strings.time,
                    style: const TextStyle(
                        color: DarkTheme.secondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                StreamBuilder<int>(
                  stream: ticker.workoutTick(workoutDuration),
                  builder: (context, snapshot) {
                    final int seconds =
                        snapshot.hasData ? snapshot.data! : workoutDuration;
                    return Text(
                      getTime(seconds),
                      style: const TextStyle(
                        color: DarkTheme.primary,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Текущий подход
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(Strings.sets,
                  style: const TextStyle(
                      color: DarkTheme.secondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: DarkTheme.backgroundSecondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$currentSet | $totalSets",
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

// Огромный обратный отсчёт – центральный элемент экрана
class _CountdownHero extends StatelessWidget {
  final int duration;
  final ReverseTicker reverseTicker;
  final VoidCallback onFinished;

  const _CountdownHero({
    required this.duration,
    required this.reverseTicker,
    required this.onFinished,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: DarkTheme.divider, width: 1),
      ),
      child: StreamBuilder<int>(
        stream: reverseTicker.reverseTick(duration),
        builder: (context, snapshot) {
          final int remaining = snapshot.hasData ? snapshot.data! : duration;
          // Если время вышло – вызываем завершение
          if (remaining <= 0) {
            WidgetsBinding.instance.addPostFrameCallback((_) => onFinished());
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text(
                Strings.exercise, // "Упражнение"
                style: const TextStyle(
                  color: DarkTheme.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                getTime(remaining, needHourses: false),
                style: const TextStyle(
                  color: DarkTheme.primary,
                  fontSize: 96,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -3,
                  height: 1,
                ),
              ),
              const SizedBox(height: 16),
              // Прогресс-бар (аналог оставшегося времени)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: LinearProgressIndicator(
                  value: duration > 0 ? remaining / duration : 1.0,
                  color: DarkTheme.primary,
                  backgroundColor: DarkTheme.divider,
                  minHeight: 4,
                ),
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }
}

// Поле ввода веса
class _WeightInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _WeightInputField({required this.controller, required this.hint});

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
          Text(Strings.weight,
              style: const TextStyle(
                  color: DarkTheme.secondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
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
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
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
                borderSide:
                    const BorderSide(color: DarkTheme.primary, width: 1.5),
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

// Геометрический фон (асимметричные фигуры)
class _ExerciseBackground extends StatelessWidget {
  const _ExerciseBackground();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          top: -50,
          right: -30,
          child: _GeoShape(
            width: 180,
            height: 180,
            rotation: 0.6,
            color: _geoColor,
            shape: _GeoShapeType.triangle,
          ),
        ),
        Positioned(
          top: 200,
          left: -25,
          child: _GeoShape(
            width: 200,
            height: 36,
            rotation: -0.3,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: 160,
          right: -20,
          child: _GeoShape(
            width: 160,
            height: 48,
            rotation: -0.65,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: -20,
          left: -10,
          child: _GeoShape(
            width: 130,
            height: 130,
            rotation: -0.8,
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
