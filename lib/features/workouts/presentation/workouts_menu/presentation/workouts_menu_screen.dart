// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';

import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/presentation/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/widgets/open_journal_card.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/widgets/workout_card_on_list.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsMenuScreen extends StatefulWidget {
  const WorkoutsMenuScreen(
      {super.key,
      required this.isConnection,
      required this.secureStorage,
      required this.workoutsRepository});

  final bool isConnection;
  final SecureStorage secureStorage;
  final WorkoutsRepository workoutsRepository;

  @override
  State<WorkoutsMenuScreen> createState() => _WorkoutsMenuScreenState();
}

class _WorkoutsMenuScreenState extends State<WorkoutsMenuScreen> {
  @override
  Widget build(BuildContext context) {
    createWorkout() {
      if (widget.isConnection) {
        Navigator.of(context).pushNamed(
          "/workouts_menu/create_workout/",
          arguments: [
            context,
            WorkoutEntity(title: "title", exercises: []),
            false,
          ],
        );
      } else {
        showSnackBar(context, Strings.haventInternetConnetion);
      }
    }

    return Scaffold(
      backgroundColor: DarkTheme.background,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 16,
          bottom: 24,
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: DarkTheme.primary,
          foregroundColor: DarkTheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          onPressed: () => createWorkout(),
          child: const Icon(
            Icons.add,
            size: 28,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundGeometryPainter(),
            ),
          ),
          BlocBuilder<WorkoutsMenuBloc, WorkoutsMenuState>(
            builder: (context, state) {
              if (state is UpdateWorkoutState) {
                if (state.workouts != null) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      24,
                      16,
                      120,
                    ),
                    itemCount: state.workouts!.length + 1,
                    itemBuilder: (context, index) {
                      final child = index == 0
                          ? OpenWorkoutsJournal()
                          : WorkoutCardOnList(
                              workoutMenuContext: context,
                              workout: state.workouts!.elementAt(index - 1),
                              index: index - 1,
                              isConnection: widget.isConnection,
                              secureStorage: widget.secureStorage,
                              workoutsRepository: widget.workoutsRepository,
                            );

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16,
                        ),
                        child: child,
                      );
                    },
                  );
                }

                return const Center(
                  child: Text(
                    "OMG NULL!",
                    style: TextStyle(
                      color: DarkTheme.secondary,
                    ),
                  ),
                );
              }

              return const LoadingScreen();
            },
          ),
        ],
      ),
    );
  }
}

// Класс для создания фоновой геометрии оставлен для возможности использования в будущем
class BackgroundGeometryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = DarkTheme.primary.withOpacity(0.05) // 3-8% opacity
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = DarkTheme.secondary.withOpacity(0.04)
      ..style = PaintingStyle.fill;

    canvas.drawLine(
      const Offset(0, 0),
      Offset(size.width * 0.4, size.height * 0.4),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height * 0.1),
      Offset(size.width * 0.6, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.2, size.height),
      Offset(size.width, 0),
      paint,
    );

    final path = Path();
    path.moveTo(size.width * 0.85, size.height * 0.05);
    path.lineTo(size.width * 0.95, size.height * 0.05);
    path.lineTo(size.width * 0.85, size.height * 0.2);
    path.close();
    canvas.drawPath(path, fillPaint);

    final path2 = Path();
    path2.moveTo(size.width * 0.1, size.height * 0.9);
    path2.lineTo(size.width * 0.2, size.height * 0.9);
    path2.lineTo(size.width * 0.1, size.height * 0.75);
    path2.close();
    canvas.drawPath(path2, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
