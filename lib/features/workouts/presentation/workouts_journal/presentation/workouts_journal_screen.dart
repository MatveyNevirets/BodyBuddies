import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/core/widgets/are_you_sure_dialog.dart';
import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/bloc/journal_workouts_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/widgets/journal_workout_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/strings/strings.dart';
import '../../../../../core/themes/colors.dart';

class WorkoutsJournalScreen extends StatelessWidget {
  const WorkoutsJournalScreen({super.key, required this.isConnection});

  final bool isConnection;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    // Адаптивные отступы
    final double horizontalPadding =
        screenWidth * 0.04 > 20 ? 20 : screenWidth * 0.04;
    const double verticalPadding = 16.0;

    void removeCurrentWorkout(int index) {
      if (isConnection) {
        context
            .read<JournalWorkoutsBloc>()
            .add(DeleteJournalWorkoutEvent(index: index));
      } else {
        showSnackBar(context, Strings.haventInternetConnetion);
      }
    }

    return Scaffold(
      backgroundColor: DarkTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: DarkTheme.primary,
            size: 26,
          ),
          onPressed: () => Navigator.of(context).pop(),
          splashRadius: 24,
        ),
        title: const Text(
          'Дневник тренировок',
          style: DarkTheme.appbar_text_style, // 20px, weight 700, primary
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // Фоновая геометрия (асимметричные линии и фигуры)
          Positioned.fill(
            child: CustomPaint(
              painter: _JournalBackgroundPainter(
                primaryColor: DarkTheme.primary,
                secondaryColor: DarkTheme.secondary,
              ),
              size: media.size,
            ),
          ),
          // Основной контент
          BlocBuilder<JournalWorkoutsBloc, JournalWorkoutsState>(
            builder: (context, state) {
              if (state is FetchJournalState) {
                if (state.journalWorkouts != null &&
                    state.journalWorkouts!.isNotEmpty) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        top: verticalPadding,
                        bottom: verticalPadding + 80,
                      ),
                      itemCount: state.journalWorkouts!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: JournalWorkoutCardItem(
                            state.journalWorkouts![index],
                            removeItem: () {
                              showAdaptiveDialog(
                                context: context,
                                builder: (context) {
                                  return _AreYouSureJournalDialog(
                                    isConnection: isConnection,
                                    index: index,
                                    onSubmit: () => removeCurrentWorkout(index),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  // Состояние "пусто" – оформлено по концепту (тёмная тема)
                  return Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: DarkTheme.surface,
                          border: Border.all(
                            color: DarkTheme.divider,
                            width: 1,
                          ),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(
                                  0xFF1F2533), // на 5% светлее DarkTheme.surface
                              DarkTheme.surface,
                            ],
                            stops: [0.0, 0.05],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.fitness_center_rounded,
                              size: 64,
                              color: DarkTheme.primary.withOpacity(0.2),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Нет завершённых тренировок',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: DarkTheme.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Здесь появятся твои выполненные программы',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: DarkTheme.secondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
              return const LoadingScreen();
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Вспомогательный диалог (без изменений)
// ============================================================================
class _AreYouSureJournalDialog extends StatelessWidget {
  final VoidCallback onSubmit;

  const _AreYouSureJournalDialog({
    required this.isConnection,
    required this.index,
    required this.onSubmit,
  });

  final bool isConnection;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AreYouSureDialog(
      onSubmit: () {
        if (isConnection) {
          try {
            Navigator.of(context).pop();
            onSubmit.call();
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

// ============================================================================
// Кастомный художник для фоновой геометрии (только тёмные цвета)
// ============================================================================
class _JournalBackgroundPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;

  _JournalBackgroundPainter({
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Линии – очень тонкие, opacity 5%
    final linePaint = Paint()
      ..color = primaryColor.withOpacity(0.05)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Заливки для фигур – opacity 3-4%
    final fillPaint = Paint()
      ..color = secondaryColor.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    // Диагональные линии (напряжение, движение)
    canvas.drawLine(
      Offset(0, size.height * 0.15),
      Offset(size.width * 0.45, size.height * 0.55),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width * 0.9, size.height * 0.4),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.8),
      Offset(size.width * 0.6, size.height),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.85, size.height * 0.6),
      Offset(size.width * 0.95, size.height * 0.95),
      linePaint,
    );

    // Вытянутые прямоугольники (асимметрия)
    final rect1 = Rect.fromLTWH(
      size.width * 0.75,
      size.height * 0.05,
      size.width * 0.2,
      size.height * 0.08,
    );
    canvas.drawRect(rect1, fillPaint..color = primaryColor.withOpacity(0.04));

    final rect2 = Rect.fromLTWH(
      size.width * 0.02,
      size.height * 0.7,
      size.width * 0.12,
      size.height * 0.15,
    );
    canvas.drawRect(
        rect2, fillPaint..color = secondaryColor.withOpacity(0.035));

    // Треугольники (разрезанные формы)
    final path1 = Path()
      ..moveTo(size.width * 0.92, size.height * 0.1)
      ..lineTo(size.width, size.height * 0.1)
      ..lineTo(size.width, size.height * 0.22)
      ..close();
    canvas.drawPath(path1, fillPaint..color = primaryColor.withOpacity(0.05));

    final path2 = Path()
      ..moveTo(size.width * 0.05, size.height * 0.88)
      ..lineTo(size.width * 0.15, size.height * 0.88)
      ..lineTo(size.width * 0.05, size.height * 0.78)
      ..close();
    canvas.drawPath(path2, fillPaint..color = secondaryColor.withOpacity(0.04));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
