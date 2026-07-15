// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';

import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/presentation/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/widgets/exercise_item_on_list.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/widgets/timer_exercise_item_on_list.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../../core/strings/strings.dart';
import '../../../../../core/themes/colors.dart';

class CreateWorkoutScreen extends StatefulWidget {
  late final WorkoutsRepository workoutsRepository;
  late final SecureStorage secureStorage;
  List<ExerciseEntity> _exercises = [];
  bool isEditWorkout = false;

  final Size screenSize;

  String? weekdayString;
  int? weekdayNum;

  final List<String> daysOfWeek = [
    Strings.monday,
    Strings.tuesday,
    Strings.wednesday,
    Strings.thursday,
    Strings.friday,
    Strings.saturday,
    Strings.sunday,
  ];

  CreateWorkoutScreen({
    super.key,
    required this.screenSize,
    required this.workoutsRepository,
    required this.secureStorage,
  });

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  Future<void> tryToCreateWorkout(
      int? weekday,
      BuildContext menuContext,
      BuildContext thisContext,
      int id,
      TextEditingController titleController) async {
    List<ExerciseEntity> newExercises = [];

    for (var exercise in widget._exercises) {
      newExercises.add(
        ExerciseEntity(
          title: exercise.title,
          isExercise: exercise.isExercise,
          isTimerExercise: exercise.isTimerExercise,
          kilograms: exercise.kilograms,
          sets: exercise.sets,
          reps: exercise.reps,
          timerTimeMinutes: exercise.timerTimeMinutes,
          timerTimeSeconds: exercise.timerTimeSeconds,
          restTimeInSeconds: exercise.restTimeInSeconds,
          restTimeInMinutes: exercise.restTimeInMinutes,
        ),
      );
    }

    if (titleController.text.toString() != "" &&
        (widget.weekdayNum != null) &&
        widget._exercises.isNotEmpty) {
      try {
        final storage = widget.secureStorage;

        final tokenJson = await storage.read(dotenv.env['TOKEN_KEY']!);
        final tokenMap = jsonDecode(tokenJson);
        final token = tokenMap['access_token'];

        if (!widget.isEditWorkout) {
          await widget.workoutsRepository.createWorkout(
              titleController.text.toString(), weekday!, newExercises, token);
        } else {
          await widget.workoutsRepository.updateWorkout(
              titleController.text.toString(),
              weekday,
              newExercises,
              id,
              token);
        }

        menuContext.read<WorkoutsMenuBloc>().add(UpdateWorkoutEvent());
        Navigator.of(menuContext).pop();
      } on Object catch (error, stack) {
        throw Exception("Error: $error, StackTrace: $stack");
      }
    } else {
      showSnackBar(menuContext, Strings.not_full_field_error);
    }
  }

  int getNumberWeekday(String weekday) {
    if (weekday == Strings.monday) {
      return 1;
    } else if (weekday == Strings.tuesday) {
      return 2;
    } else if (weekday == Strings.wednesday) {
      return 3;
    } else if (weekday == Strings.thursday) {
      return 4;
    } else if (weekday == Strings.friday) {
      return 5;
    } else if (weekday == Strings.saturday) {
      return 6;
    } else if (weekday == Strings.sunday) {
      return 7;
    } else {
      return -1;
    }
  }

  late TextEditingController titleTextFieldController;

  @override
  void initState() {
    super.initState();
    titleTextFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final modalRouteData = ModalRoute.of(context)!.settings.arguments as List;

    final workoutsMenuContext = modalRouteData[0] as BuildContext;
    final workoutEntity = modalRouteData[1] as WorkoutEntity;
    widget.isEditWorkout = modalRouteData[2] as bool;

    int workoutId = 0;

    if (widget.isEditWorkout) {
      if (!const ListEquality()
              .equals(workoutEntity.exercises, widget._exercises) &&
          widget._exercises.isEmpty) {
        widget._exercises = workoutEntity.exercises;
      }

      widget.weekdayString = widget.daysOfWeek[workoutEntity.weekday - 1];
      widget.weekdayNum = getNumberWeekday(widget.weekdayString!);

      titleTextFieldController.text =
          widget.isEditWorkout ? workoutEntity.title.toString() : "";

      workoutId = workoutEntity.id;
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
        title: Text(
          widget.isEditWorkout ? 'Редактирование' : 'Создание тренировки',
          style: DarkTheme.appbar_text_style,
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // Фоновая геометрия — напряжение и движение
          Positioned.fill(
            child: CustomPaint(
              painter: _CreateWorkoutBackgroundPainter(
                primaryColor: DarkTheme.primary,
                secondaryColor: DarkTheme.secondary,
              ),
            ),
          ),
          // Центрируем контент с максимальной шириной для премиального вида
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Container(
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
                        Color(0xFF1F2533), // на ~5% светлее surface
                        DarkTheme.surface,
                      ],
                      stops: [0.0, 0.05],
                    ),
                    boxShadow: [
                      // Тень почти отсутствует, как и требует тёмная тема концепта
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20), // кратно 4, близко к 20
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Название тренировки
                        TextField(
                          controller: titleTextFieldController,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                            color: DarkTheme.primary,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: DarkTheme.backgroundSecondary,
                            hintText: Strings.title,
                            hintStyle: DarkTheme.hint_text_style_create_workout,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: DarkTheme.divider,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: DarkTheme.divider,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: DarkTheme.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Список упражнений
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: DarkTheme.backgroundSecondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              ReorderableListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget._exercises.length,
                                proxyDecorator: (child, index, animation) {
                                  // Убираем стандартную "белую" окантовку и тень
                                  return AnimatedBuilder(
                                    animation: animation,
                                    builder: (context, child) {
                                      return Material(
                                        color: Colors.transparent,
                                        elevation: 0,
                                        child: child,
                                      );
                                    },
                                    child: child,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  if (widget._exercises.isEmpty) {
                                    return const SizedBox();
                                  }
                                  if (widget._exercises[index].isExercise) {
                                    return ExerciseItemOnList(
                                      key: ValueKey(
                                          widget._exercises[index].title),
                                      context,
                                      widget.screenSize,
                                      index,
                                      widget._exercises,
                                      widget.isEditWorkout,
                                      onRemoveItem: () {
                                        removeItem(index);
                                      },
                                    );
                                  } else if (widget
                                      ._exercises[index].isTimerExercise) {
                                    return TimerExerciseItemOnList(
                                      key: ValueKey(
                                          widget._exercises[index].title),
                                      context,
                                      widget.screenSize,
                                      index,
                                      widget._exercises,
                                      widget.isEditWorkout,
                                      onRemoveItem: () {
                                        removeItem(index);
                                      },
                                    );
                                  }
                                  return const SizedBox
                                      .shrink(); // никогда не случится
                                },
                                onReorder: (int oldIndex, int newIndex) {
                                  setState(() {
                                    if (newIndex > oldIndex) {
                                      newIndex -= 1;
                                    }
                                    final item =
                                        widget._exercises.removeAt(oldIndex);
                                    widget._exercises.insert(newIndex, item);
                                  });
                                },
                              ),
                              const SizedBox(height: 16),

                              // Кнопка добавления упражнения (вторичная)
                              BaseButton(
                                onClick: () => goToAddExercise(context),
                                buttonText: Strings.add,
                                icon: null,
                                isElevated: false,
                                radius: 14,
                                backgroundColor: DarkTheme.divider,
                                color: DarkTheme.primary,
                                buttonSize: const Size.fromHeight(48),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Выбор дня недели
                        DropdownButtonFormField<String>(
                          isDense: true,
                          dropdownColor: DarkTheme.surface,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: DarkTheme.backgroundSecondary,
                            hintText: Strings.day,
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: DarkTheme.primary,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: DarkTheme.divider,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: DarkTheme.divider,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: DarkTheme.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                          initialValue: widget.weekdayString,
                          items: widget.daysOfWeek.map((String day) {
                            return DropdownMenuItem<String>(
                              value: day,
                              child: Center(
                                child: Text(
                                  day,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: DarkTheme
                                        .primary, // элементы списка тоже primary
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              widget.weekdayNum = getNumberWeekday(newValue!);
                            });
                          },
                        ),
                        const SizedBox(height: 24),

                        // Основная кнопка завершения
                        BaseButton(
                          onClick: () => tryToCreateWorkout(
                            widget.weekdayNum,
                            workoutsMenuContext,
                            context,
                            workoutId,
                            titleTextFieldController,
                          ),
                          buttonText: Strings.done,
                          icon: null,
                          isElevated: true,
                          radius: 14,
                          backgroundColor: DarkTheme.primary,
                          color: DarkTheme.background,
                          buttonSize: const Size.fromHeight(52),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void removeItem(int index) {
    setState(() {
      widget._exercises.removeAt(index);
    });
  }

  void goToAddExercise(BuildContext buildContext) async {
    final ExerciseOnListEntity? exercise = await Navigator.pushNamed(
            context, "/workouts_menu/create_workout/add_exercise/")
        as ExerciseOnListEntity?;

    if (exercise != null) {
      setState(() {
        ExerciseEntity newExercise = ExerciseEntity(
            title: exercise.title,
            isExercise: exercise.isExercise,
            isTimerExercise: exercise.isExercise ? false : true);

        for (int i = 0; i < widget._exercises.length; i++) {
          if (widget._exercises[i].title == newExercise.title) {
            showSnackBar(context, Strings.youCantAddExerciseAgain);
            return;
          }
        }

        widget._exercises.add(newExercise);
      });
    } else {
      return null;
    }
  }
}

String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}

// ============================================================================
// Художник фоновой геометрии — напряжение и движение
// ============================================================================
class _CreateWorkoutBackgroundPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;

  _CreateWorkoutBackgroundPainter({
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

    // Диагональные линии — создают ощущение вектора усилия
    canvas.drawLine(
      Offset(0, size.height * 0.12),
      Offset(size.width * 0.45, size.height * 0.55),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.8, 0),
      Offset(size.width * 0.92, size.height * 0.25),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.15, size.height * 0.85),
      Offset(size.width * 0.7, size.height),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.9, size.height * 0.7),
      Offset(size.width, size.height * 0.92),
      linePaint,
    );

    // Вытянутые прямоугольники — словно плиты
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.06,
        size.height * 0.18,
        size.width * 0.13,
        size.height * 0.07,
      ),
      fillPaint..color = primaryColor.withOpacity(0.05),
    );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.83,
        size.height * 0.62,
        size.width * 0.14,
        size.height * 0.08,
      ),
      fillPaint..color = secondaryColor.withOpacity(0.04),
    );

    // Треугольники — напряжённая геометрия
    final triangle1 = Path()
      ..moveTo(size.width * 0.92, size.height * 0.06)
      ..lineTo(size.width, size.height * 0.06)
      ..lineTo(size.width, size.height * 0.18)
      ..close();
    canvas.drawPath(
        triangle1, fillPaint..color = primaryColor.withOpacity(0.06));

    final triangle2 = Path()
      ..moveTo(size.width * 0.04, size.height * 0.88)
      ..lineTo(size.width * 0.12, size.height * 0.88)
      ..lineTo(size.width * 0.04, size.height * 0.76)
      ..close();
    canvas.drawPath(
        triangle2, fillPaint..color = secondaryColor.withOpacity(0.05));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Старый класс оставлен для возможной обратной совместимости
class BackgroundGeometryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = DarkTheme.primary.withOpacity(0.05)
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
