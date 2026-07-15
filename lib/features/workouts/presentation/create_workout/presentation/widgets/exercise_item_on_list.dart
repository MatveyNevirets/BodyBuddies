import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/strings/strings.dart';
import '../../../../../../core/themes/colors.dart';

class ExerciseItemOnList extends StatefulWidget {
  final BuildContext context;
  final Size screenSize;
  final int index;
  final List<ExerciseEntity> exercises;

  final VoidCallback onRemoveItem;

  bool isEdited = false;

  ExerciseItemOnList(
      this.context, this.screenSize, this.index, this.exercises, this.isEdited,
      {super.key, required this.onRemoveItem});

  @override
  State<ExerciseItemOnList> createState() => _ExerciseItemOnListState();
}

class _ExerciseItemOnListState extends State<ExerciseItemOnList> {
  late TextEditingController weightController;
  late TextEditingController setsController;
  late TextEditingController repsController;
  late TextEditingController restTimeOfMinutesController;
  late TextEditingController restTimeOfSecondsController;

  @override
  void initState() {
    super.initState();
    weightController = TextEditingController();
    setsController = TextEditingController();
    repsController = TextEditingController();
    restTimeOfMinutesController = TextEditingController();
    restTimeOfSecondsController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // Заполнение контроллеров, если упражнение уже редактировано
    if (widget.isEdited) {
      var exercise = widget.exercises[widget.index];
      weightController.text = exercise.kilograms == exercise.kilograms.toInt()
          ? exercise.kilograms.toInt().toString()
          : exercise.kilograms.toString();
      setsController.text = exercise.sets.toString();
      repsController.text = exercise.reps.toString();
      restTimeOfMinutesController.text = exercise.restTimeInMinutes.toString();
      restTimeOfSecondsController.text = exercise.restTimeInSeconds.toString();
    }

    final screenWidth = widget.screenSize.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: DarkTheme.surface,
          border: Border.all(color: DarkTheme.divider, width: 1),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1F2533),
              DarkTheme.surface,
            ],
            stops: [0.0, 0.05],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок упражнения
            Row(
              children: [
                // Номер
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: DarkTheme.backgroundSecondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    (widget.index + 1).toString(),
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: DarkTheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Название (обрезанное)
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: DarkTheme.backgroundSecondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      truncateText(widget.exercises[widget.index].title, 20),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: DarkTheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Кнопка удаления
                GestureDetector(
                  onTap: () => widget.onRemoveItem.call(),
                  child: const Icon(
                    Icons.delete_outline,
                    size: 22,
                    color: DarkTheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Параметры: вес, подходы, повторения
            Row(
              children: [
                _buildAdaptiveField(
                  label: Strings.weight,
                  controller: weightController,
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      widget.exercises[widget.index].kilograms =
                          double.parse(v);
                    } else {
                      widget.exercises[widget.index].kilograms = 0;
                    }
                  },
                ),
                const SizedBox(width: 8),
                _buildAdaptiveField(
                  label: Strings.sets,
                  controller: setsController,
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      widget.exercises[widget.index].sets = int.parse(v);
                    } else {
                      widget.exercises[widget.index].sets = 0;
                    }
                  },
                ),
                const SizedBox(width: 8),
                _buildAdaptiveField(
                  label: Strings.reps,
                  controller: repsController,
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      widget.exercises[widget.index].reps = int.parse(v);
                    } else {
                      widget.exercises[widget.index].reps = 0;
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Отдых
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Отдых',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: DarkTheme.secondary,
                  ),
                ),
                const SizedBox(width: 8),
                _buildAdaptiveField(
                  label: Strings.minutes,
                  controller: restTimeOfMinutesController,
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      widget.exercises[widget.index].restTimeInMinutes =
                          int.parse(v);
                    } else {
                      widget.exercises[widget.index].restTimeInMinutes = 0;
                    }
                  },
                ),
                const SizedBox(width: 8),
                _buildAdaptiveField(
                  label: Strings.seconds,
                  controller: restTimeOfSecondsController,
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      widget.exercises[widget.index].restTimeInSeconds =
                          int.parse(v);
                    } else {
                      widget.exercises[widget.index].restTimeInSeconds = 0;
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Адаптивное поле ввода – занимает равную долю в строке
  Widget _buildAdaptiveField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return Expanded(
      child: SizedBox(
        height: 42,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          maxLength: 4,
          buildCounter: null,
          keyboardType: TextInputType.number,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: DarkTheme.primary,
          ),
          cursorColor: DarkTheme.primary,
          decoration: InputDecoration(
            filled: true,
            fillColor: DarkTheme.backgroundSecondary,
            contentPadding:
                const EdgeInsets.only(bottom: 12, left: 8, right: 8),
            labelText: label,
            labelStyle: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: DarkTheme.secondary,
            ),
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: DarkTheme.divider, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: DarkTheme.divider, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: DarkTheme.primary, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }
}
