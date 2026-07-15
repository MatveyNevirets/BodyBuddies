import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/strings/strings.dart';
import '../../../../../../core/themes/colors.dart';

class TimerExerciseItemOnList extends StatefulWidget {
  final BuildContext context;
  final Size screenSize;
  final int index;
  final List<ExerciseEntity> exercises;

  final VoidCallback onRemoveItem;

  TimerExerciseItemOnList(
      this.context, this.screenSize, this.index, this.exercises, this.isEdited,
      {super.key, required this.onRemoveItem});

  bool isEdited = false;

  @override
  State<TimerExerciseItemOnList> createState() =>
      _TimerExerciseItemOnListState();
}

class _TimerExerciseItemOnListState extends State<TimerExerciseItemOnList> {
  late TextEditingController exerciseMinutesController;
  late TextEditingController exerciseSecondsController;
  late TextEditingController setsController;
  late TextEditingController weightController;
  late TextEditingController restMinutesController;
  late TextEditingController restSecondsController;

  @override
  void initState() {
    super.initState();
    exerciseMinutesController = TextEditingController();
    exerciseSecondsController = TextEditingController();
    weightController = TextEditingController();
    setsController = TextEditingController();
    restMinutesController = TextEditingController();
    restSecondsController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // Заполнение контроллеров при редактировании
    if (widget.isEdited) {
      final ex = widget.exercises[widget.index];
      weightController.text = ex.kilograms == ex.kilograms.toInt()
          ? ex.kilograms.toInt().toString()
          : ex.kilograms.toString();
      setsController.text = ex.sets.toString();
      restMinutesController.text = ex.restTimeInMinutes.toString();
      restSecondsController.text = ex.restTimeInSeconds.toString();
      exerciseMinutesController.text = ex.timerTimeMinutes.toString();
      exerciseSecondsController.text = ex.timerTimeSeconds.toString();
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
            // ───── Заголовок упражнения ─────
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
                // Название
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
                // Удалить
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

            // ───── Время выполнения упражнения ─────
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    Strings.time_of_timer_exercise,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: DarkTheme.secondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                _buildAdaptiveField(
                  label: Strings.minutes,
                  controller: exerciseMinutesController,
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      widget.exercises[widget.index].timerTimeMinutes =
                          int.parse(v);
                    } else {
                      widget.exercises[widget.index].timerTimeMinutes = 0;
                    }
                  },
                ),
                const SizedBox(width: 8),
                _buildAdaptiveField(
                  label: Strings.seconds,
                  controller: exerciseSecondsController,
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      widget.exercises[widget.index].timerTimeSeconds =
                          int.parse(v);
                    } else {
                      widget.exercises[widget.index].timerTimeSeconds = 0;
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ───── Параметры: подходы, вес ─────
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    Strings.add_timer_exercise_parameters,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: DarkTheme.secondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
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
              ],
            ),
            const SizedBox(height: 12),

            // ───── Отдых ─────
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 70,
                  child: Text(
                    'Отдых',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: DarkTheme.secondary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _buildAdaptiveField(
                  label: Strings.minutes,
                  controller: restMinutesController,
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
                  controller: restSecondsController,
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
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  // Адаптивное поле ввода – растягивается внутри Expanded
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
