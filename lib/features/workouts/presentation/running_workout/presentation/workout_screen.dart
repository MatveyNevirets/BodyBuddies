// lib/features/workouts/presentation/running_workout/presentation/workout_screen.dart
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/presentation/bloc/running_workout_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/workout_ticker/workout_ticker.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/strings/strings.dart';
import 'exercise_screen.dart';
import 'rest_screen.dart';
import 'timer_exercise_screen.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({
    super.key,
    required this.workoutsRepository,
    required this.secureStorage,
  });

  final WorkoutsRepository workoutsRepository;
  final SecureStorage secureStorage;

  @override
  Widget build(BuildContext context) {
    final WorkoutEntity workout =
        ModalRoute.of(context)!.settings.arguments as WorkoutEntity;
    final WorkoutTicker ticker = WorkoutTicker();
    final WorkoutEntity workoutToJournal =
        WorkoutEntity(title: workout.title, exercises: []);

    return BlocProvider(
      create: (_) {
        final bloc = RunningWorkoutBloc(
          workout.exercises,
          0,
          workoutsRepository,
          secureStorage,
        );
        bloc.exercises[bloc.state.currentExercise].currentSets = 1;
        return bloc;
      },
      child: Scaffold(
        backgroundColor: DarkTheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded,
                color: DarkTheme.primary, size: 24),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            workout.title ?? Strings.workout, // fallback
            style: DarkTheme.appbar_text_style,
          ),
          centerTitle: false,
        ),
        body: Stack(
          children: [
            // Геометрический фон (как на других экранах тренировки)
            const Positioned.fill(
              child: _WorkoutBackground(),
            ),
            SafeArea(
              child: BlocConsumer<RunningWorkoutBloc, RunningWorkoutState>(
                listener: (context, state) {
                  if (state is CompleteWorkout) {
                    completeWorkout(context);
                  }
                },
                builder: (context, state) {
                  return BlocBuilder<RunningWorkoutBloc, RunningWorkoutState>(
                    builder: (context, state) {
                      if (state is WorkoutInProcess) {
                        final exercise = state.exercises[state.currentExercise];
                        if (exercise.isExercise) {
                          return ExerciseScreen(
                            exercise,
                            ticker,
                            state.duration,
                            state,
                            workoutToJournal,
                          );
                        } else if (exercise.isTimerExercise) {
                          return TimerExerciseScreen(
                            exercise,
                            ticker,
                            state.duration,
                            state,
                            workoutToJournal,
                          );
                        }
                      } else if (state is RestWorkoutProcess) {
                        return RestScreen(
                          ticker: ticker,
                          workoutTimerDuration: state.duration,
                          exercise: state.exercises[state.currentExercise],
                        );
                      }
                      return const LoadingScreen();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void completeWorkout(BuildContext context) {
    showSnackBar(context, Strings.completedSuccessful);
    Navigator.of(context).pop();
  }
}

// Геометрический фон для экрана тренировки
class _WorkoutBackground extends StatelessWidget {
  const _WorkoutBackground();

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
            rotation: 0.4,
            color: _geoColor,
            shape: _GeoShapeType.triangle,
          ),
        ),
        Positioned(
          top: 160,
          left: -30,
          child: _GeoShape(
            width: 240,
            height: 40,
            rotation: -0.2,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: 100,
          right: -30,
          child: _GeoShape(
            width: 190,
            height: 50,
            rotation: -0.45,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: -50,
          left: -20,
          child: _GeoShape(
            width: 180,
            height: 180,
            rotation: -0.6,
            color: _geoColor,
            shape: _GeoShapeType.triangle,
          ),
        ),
      ],
    );
  }

  static const Color _geoColor = DarkTheme.primary;
}

// Переиспользуемые геометрические примитивы
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

// Вспомогательная функция форматирования времени (общая для всех экранов)
String getTime(int duration, {bool needHourses = true}) {
  String hoursStr =
      (((duration / 60) / 60) % 60).floor().toString().padLeft(2, '0');
  String minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
  String secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
  return needHourses
      ? '$hoursStr:$minutesStr:$secondsStr'
      : '$minutesStr:$secondsStr';
}
