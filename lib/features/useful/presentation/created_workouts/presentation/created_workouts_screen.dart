// lib/features/useful/presentation/created_workouts/presentation/created_workouts_screen.dart
import 'dart:developer';

import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/useful/presentation/created_workouts/presentation/bloc/created_workouts_bloc.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/workout_create_screen.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/widgets/new_workout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatedWorkoutsScreen extends StatelessWidget {
  const CreatedWorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void addWorkout(int index) {
      context
          .read<CreatedWorkoutsBloc>()
          .add(AddCreatedWorkoutEvent(index: index));
    }

    void openWorkout(WorkoutEntity workout) {
      Navigator.of(context).pushNamed(
        "workouts_menu/current_workout/",
        arguments: [workout, 0],
      );
    }

    return Scaffold(
      backgroundColor: DarkTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: DarkTheme.divider,
                  width: 1.5,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    DarkTheme.primary.withOpacity(0.18),
                    DarkTheme.secondary.withOpacity(0.12),
                  ],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: DarkTheme.primary,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            'Готовые программы',
            style: DarkTheme.appbar_text_style,
          ),
        ),
        centerTitle: false,
        titleSpacing: 8,
      ),
      body: Stack(
        children: [
          // Геометрический фон
          const Positioned.fill(
            child: _GeometricBackground(),
          ),
          SafeArea(
            child: BlocConsumer<CreatedWorkoutsBloc, CreatedWorkoutsState>(
              listener: (context, state) {
                if (state is CreatedWorkoutAddedState) {
                  showSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is FetchCreatedWorkoutsState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      itemCount: state.workouts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GestureDetector(
                            onTap: () => openWorkout(state.workouts[index]),
                            child: Container(
                              padding: const EdgeInsets.only(
                                right: 14,
                                top: 10,
                                bottom: 10,
                              ),
                              decoration: BoxDecoration(
                                color: DarkTheme.surface,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: DarkTheme.divider,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 4),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image(
                                      image: const AssetImage(
                                        "assets/images/workout_image.png",
                                      ),
                                      height:
                                          MediaQuery.sizeOf(context).height /
                                              14,
                                      width: MediaQuery.sizeOf(context).height /
                                          14,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Expanded(
                                    child: SizedBox(),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        truncateText(
                                          state.workouts[index].title
                                              .toString(),
                                          12,
                                        ),
                                        style: DarkTheme
                                            .workout_text_style_dark_theme
                                            .copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: DarkTheme.primary,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      NewWorkoutButton(
                                        title: Strings.add,
                                        () => addWorkout(index),
                                        Size(
                                          MediaQuery.sizeOf(context).width / 5,
                                          MediaQuery.sizeOf(context).width / 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                return const LoadingScreen();
              },
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
          top: -40,
          right: -30,
          child: _GeoShape(
            width: 160,
            height: 160,
            rotation: 0.5,
            color: _geoColor,
            shape: _GeoShapeType.triangle,
          ),
        ),
        Positioned(
          top: 180,
          left: -20,
          child: _GeoShape(
            width: 200,
            height: 32,
            rotation: -0.25,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: 100,
          right: -25,
          child: _GeoShape(
            width: 170,
            height: 50,
            rotation: -0.45,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: -30,
          left: -10,
          child: _GeoShape(
            width: 150,
            height: 150,
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
