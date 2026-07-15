// lib/features/workouts/presentation/running_workout/presentation/rest_screen.dart
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/presentation/bloc/running_workout_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/presentation/workout_screen.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/workout_ticker/reverse_ticker.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/workout_ticker/workout_ticker.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class RestScreen extends StatefulWidget {
  final WorkoutTicker ticker;
  final int workoutTimerDuration;
  final ExerciseEntity exercise;

  const RestScreen({
    super.key,
    required this.ticker,
    required this.workoutTimerDuration,
    required this.exercise,
  });

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  late final ReverseTicker reverseTicker;
  late final AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    reverseTicker = ReverseTicker();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int restDuration = widget.exercise.restTimeInMinutes * 60 +
        widget.exercise.restTimeInSeconds;

    return Scaffold(
      backgroundColor: DarkTheme.background,
      body: Stack(
        children: [
          // Геометрический фон (асимметричные фигуры 5% прозрачности)
          const Positioned.fill(
            child: _RestBackground(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  // Заголовок экрана отдыха
                  Text(
                    Strings.rest, // предположим, есть ключ "rest" = "Отдых"
                    style: DarkTheme.appbar_text_style.copyWith(
                      color: DarkTheme.secondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Плитка общего таймера тренировки
                  _WorkoutTimerPanel(
                    ticker: widget.ticker,
                    workoutTimerDuration: widget.workoutTimerDuration,
                  ),
                  const SizedBox(height: 24),
                  // Центральная плитка с обратным отсчётом отдыха
                  Expanded(
                    child: _RestCountdownPanel(restDuration: restDuration),
                  ),
                  const SizedBox(height: 24),
                  // Кнопка "Пропустить"
                  BaseButton(
                    onClick: () => _skipRest(context),
                    buttonText: Strings.skip,
                    icon: Icons.skip_next_rounded,
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

  void _skipRest(BuildContext context) {
    _playDoneSound();
    context
        .read<RunningWorkoutBloc>()
        .add(ExerciseRunEvent(widget.workoutTimerDuration));
  }

  Future<void> _playDoneSound() async {
    try {
      await audioPlayer.setAsset('assets/audio/done_audio.mp3');
      audioPlayer.play();
    } catch (e) {
      throw Exception(e);
    }
  }
}

// Плитка с таймером всей тренировки (слева)
class _WorkoutTimerPanel extends StatelessWidget {
  final WorkoutTicker ticker;
  final int workoutTimerDuration;

  const _WorkoutTimerPanel({
    required this.ticker,
    required this.workoutTimerDuration,
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
          Text(
            Strings.timeOfWorkout, // "Время тренировки"
            style: const TextStyle(
              color: DarkTheme.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          StreamBuilder<int>(
            stream: ticker.workoutTick(workoutTimerDuration),
            builder: (context, snapshot) {
              final int current;
              if (snapshot.hasData) {
                current = snapshot.data!;
              } else {
                current = workoutTimerDuration;
              }
              return Text(
                getTime(current),
                style: const TextStyle(
                  color: DarkTheme.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Плитка с обратным отсчётом отдыха (центральная)
class _RestCountdownPanel extends StatelessWidget {
  final int restDuration;

  const _RestCountdownPanel({required this.restDuration});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: DarkTheme.divider, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Strings.rest, // "Отдых"
            style: const TextStyle(
              color: DarkTheme.secondary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          // Обратный таймер
          StreamBuilder<int>(
            stream: ReverseTicker().reverseTick(restDuration),
            builder: (context, snapshot) {
              final int remaining;
              if (snapshot.hasData) {
                remaining = snapshot.data!;
              } else {
                remaining = restDuration;
              }
              return Text(
                getTime(remaining, needHourses: false),
                style: const TextStyle(
                  color: DarkTheme.primary,
                  fontSize: 72,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -2,
                  height: 1,
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'осталось до конца отдыха',
            style: const TextStyle(
              color: DarkTheme.secondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Геометрический фон (аналогичен другим экранам)
class _RestBackground extends StatelessWidget {
  const _RestBackground();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          top: -60,
          right: -40,
          child: _GeoShape(
            width: 200,
            height: 200,
            rotation: 0.45,
            color: _geoColor,
            shape: _GeoShapeType.triangle,
          ),
        ),
        Positioned(
          top: 180,
          left: -20,
          child: _GeoShape(
            width: 220,
            height: 40,
            rotation: -0.25,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: 100,
          right: -25,
          child: _GeoShape(
            width: 180,
            height: 50,
            rotation: -0.5,
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

// Переиспользуемые гео-фигуры
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