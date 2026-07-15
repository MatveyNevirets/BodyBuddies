// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:async';

import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/workouts/presentation/add_exercise/bloc/exercises_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/strings/strings.dart';
import '../../../../../core/themes/themes.dart';

class AddExerciseScreen extends StatelessWidget {
  final searchTextFieldController = TextEditingController();

  AddExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void searchExercises() {
      String query =
          searchTextFieldController.text.toLowerCase().replaceAll(" ", "");

      context.read<ExercisesBloc>().add(
            SearchEvent(context, query),
          );
    }

    searchTextFieldController.addListener(searchExercises);

    Future<void> addYourExercise(BuildContext context) async {
      final createdExercise = await Navigator.of(context).pushNamed(
              "/workouts_menu/create_workout/add_exercise/add_your_exercise/")
          as ExerciseOnListEntity?;

      context
          .read<ExercisesBloc>()
          .add(AddYourExerciseEvent(context, createdExercise));
    }

    return Scaffold(
      backgroundColor: DarkTheme.background,
      // Фоновая геометрия для напряжения и движения
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _AddExerciseBackgroundPainter(
                primaryColor: DarkTheme.primary,
                secondaryColor: DarkTheme.secondary,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    // Верхняя панель: строка поиска и кнопка "Назад" (без AppBar)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Row(
                        children: [
                          // Кнопка назад — минималистичная, строгая
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => Navigator.of(context).pop(),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  color: DarkTheme.primary,
                                  size: 26,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Поле поиска
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: DarkTheme.backgroundSecondary,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: DarkTheme.divider,
                                  width: 1,
                                ),
                              ),
                              child: TextField(
                                controller: searchTextFieldController,
                                cursorColor: DarkTheme.primary,
                                style: DarkTheme.body_text_style,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 12,
                                  ),
                                  hintStyle:
                                      DarkTheme.hint_text_style_create_workout,
                                  hintText: Strings.search,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Список упражнений
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: buildExercisesListView(context),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Кнопка добавления своего упражнения
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: BaseButton(
                        onClick: () async => await addYourExercise(context),
                        buttonText: Strings.add_yourself,
                        backgroundColor: DarkTheme.primary,
                        color: DarkTheme.background,
                        radius: 14,
                        buttonSize: const Size(double.infinity, 52),
                        icon: null,
                        isElevated: true,
                      ),
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

  Expanded buildExercisesListView(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: DarkTheme.surface,
          border: Border.all(
            color: DarkTheme.divider,
            width: 1,
          ),
          // Едва заметная тень — как у «плиты»
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
          // Лёгкий градиент для ощущения металла
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1F2533), // чуть светлее surface
              DarkTheme.surface,
            ],
            stops: [0.0, 0.05],
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<ExercisesBloc, ExercisesState>(
          builder: (context, state) {
            if (state is SearchExericsesState) {
              return ListView.builder(
                itemCount: state.exercises.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  // Используем Material + InkWell для микро-взаимодействия (ripple + сжатие через splash)
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => addExercise(context, index, state),
                        splashColor: DarkTheme.primary.withOpacity(0.08),
                        highlightColor: DarkTheme.primary.withOpacity(0.04),
                        child: AnimatedScale(
                          scale: 1.0,
                          duration: const Duration(milliseconds: 120),
                          // Само сжатие реализуем через onTap состояние, но для простоты оставим InkWell
                          child: Container(
                            decoration: BoxDecoration(
                              color: DarkTheme.backgroundSecondary,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: DarkTheme.divider,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: const Image(
                                      image: AssetImage(
                                        "assets/images/workout_image.png",
                                      ),
                                      height: 64,
                                      width: 64,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      truncateText(
                                        state.exercises[index].title,
                                        50,
                                      ),
                                      style: DarkTheme.add_exercise_text_style,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    color: DarkTheme.secondary,
                                    size: 22,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const LoadingScreen();
            }
          },
        ),
      ),
    );
  }

  void addExercise(
      BuildContext context, int index, SearchExericsesState state) {
    final newExercise = state.exercises[index];
    Navigator.of(context).pop(newExercise);
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}

// ============================================================================
// Художник фоновой геометрии для экрана добавления упражнения
// ============================================================================
class _AddExerciseBackgroundPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;

  _AddExerciseBackgroundPainter({
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = primaryColor.withOpacity(0.05)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = secondaryColor.withOpacity(0.04)
      ..style = PaintingStyle.fill;

    // Энергичные диагонали
    canvas.drawLine(
      Offset(0, size.height * 0.08),
      Offset(size.width * 0.35, size.height * 0.45),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width * 0.88, size.height * 0.3),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.78),
      Offset(size.width * 0.6, size.height * 0.95),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.85, size.height * 0.6),
      Offset(size.width * 0.95, size.height * 0.85),
      linePaint,
    );

    // Вытянутые прямоугольники — как снаряды
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.08, size.height * 0.12, size.width * 0.11,
          size.height * 0.06),
      fillPaint..color = primaryColor.withOpacity(0.05),
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.78, size.height * 0.7, size.width * 0.13,
          size.height * 0.07),
      fillPaint..color = secondaryColor.withOpacity(0.04),
    );

    // Треугольники — напряжение
    final triangle1 = Path()
      ..moveTo(size.width * 0.9, size.height * 0.04)
      ..lineTo(size.width * 0.97, size.height * 0.04)
      ..lineTo(size.width * 0.97, size.height * 0.15)
      ..close();
    canvas.drawPath(
        triangle1, fillPaint..color = primaryColor.withOpacity(0.06));

    final triangle2 = Path()
      ..moveTo(size.width * 0.03, size.height * 0.88)
      ..lineTo(size.width * 0.12, size.height * 0.88)
      ..lineTo(size.width * 0.03, size.height * 0.75)
      ..close();
    canvas.drawPath(
        triangle2, fillPaint..color = secondaryColor.withOpacity(0.05));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
