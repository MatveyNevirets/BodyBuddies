import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/strings/strings.dart';
import '../../../../../../core/themes/colors.dart';
import '../workout_create_screen.dart';

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
    String? weightText;
    String? setsText;
    String? restSecondsText;
    String? restMinutesText;
    String? exerciseSecondsText;
    String? exerciseMinutesText;

    if (widget.isEdited) {
      var weight = widget.exercises[widget.index].kilograms;
      var sets = widget.exercises[widget.index].sets;
      var restTimeOfSeconds = widget.exercises[widget.index].restTimeInSeconds;
      var restTimeOfMinutes = widget.exercises[widget.index].restTimeInMinutes;
      var exerciseTimeMinutes = widget.exercises[widget.index].timerTimeMinutes;
      var exericseTimeSeconds = widget.exercises[widget.index].timerTimeSeconds;

      weight == weight.toInt()
          ? weightText = weight.toInt().toString()
          : weightText = weight.toString();

      sets == sets.toInt()
          ? setsText = sets.toInt().toString()
          : setsText = sets.toString();

      restMinutesText = restTimeOfMinutes.toString();
      restSecondsText = restTimeOfSeconds.toString();

      exerciseMinutesText = exerciseTimeMinutes.toString();
      exerciseSecondsText = exericseTimeSeconds.toString();

      weightController.text = widget.isEdited ? weightText.toString() : "";
      setsController.text = widget.isEdited ? setsText.toString() : "";
      restMinutesController.text =
          widget.isEdited ? restMinutesText.toString() : "";
      restSecondsController.text =
          widget.isEdited ? restSecondsText.toString() : "";
      exerciseMinutesController.text =
          widget.isEdited ? exerciseMinutesText.toString() : "";
      exerciseSecondsController.text =
          widget.isEdited ? exerciseSecondsText.toString() : "";
    }

    final screenWidth = widget.screenSize.width;
    final double cardPadding =
        screenWidth * 0.04 > 12 ? 12 : screenWidth * 0.04;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: DarkTheme.surface,
          border: Border.all(
            color: DarkTheme.divider,
            width: 1,
          ),
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
        child: Padding(
          padding: EdgeInsets.all(cardPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Шапка: иконка, номер, удаление
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: DarkTheme.backgroundSecondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
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
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: DarkTheme.backgroundSecondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        truncateText(widget.exercises[widget.index].title, 20),
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
                  GestureDetector(
                    onTap: () => removeExercise(),
                    child: const Icon(
                      Icons.delete_outline,
                      size: 26,
                      color: DarkTheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Инпуты времени упражнения
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.time_of_timer_exercise,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: DarkTheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildInputField(
                    screenWidth / 6,
                    Strings.minutes,
                    exerciseMinutesController,
                    (value) {
                      if (value.isNotEmpty) {
                        widget.exercises[widget.index].timerTimeMinutes =
                            int.parse(value);
                      } else {
                        widget.exercises[widget.index].timerTimeMinutes = 0;
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  _buildInputField(
                    screenWidth / 6,
                    Strings.seconds,
                    exerciseSecondsController,
                    (value) {
                      if (value.isNotEmpty) {
                        widget.exercises[widget.index].timerTimeSeconds =
                            int.parse(value);
                      } else {
                        widget.exercises[widget.index].timerTimeSeconds = 0;
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Параметры: подходы, вес
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.add_timer_exercise_parameters,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: DarkTheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildInputField(
                    screenWidth / 6,
                    Strings.sets,
                    setsController,
                    (value) {
                      if (value.isNotEmpty) {
                        widget.exercises[widget.index].sets = int.parse(value);
                      } else {
                        widget.exercises[widget.index].sets = 0;
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  _buildInputField(
                    screenWidth / 6,
                    Strings.weight,
                    weightController,
                    (value) {
                      if (value.isNotEmpty) {
                        widget.exercises[widget.index].kilograms =
                            double.parse(value);
                      } else {
                        widget.exercises[widget.index].kilograms = 0;
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Отдых
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.rest_of_sets,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: DarkTheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildInputField(
                    screenWidth / 7,
                    Strings.minutes,
                    restMinutesController,
                    (value) {
                      if (value.isNotEmpty) {
                        widget.exercises[widget.index].restTimeInMinutes =
                            int.parse(value);
                      } else {
                        widget.exercises[widget.index].restTimeInMinutes = 0;
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  _buildInputField(
                    screenWidth / 7,
                    Strings.seconds,
                    restSecondsController,
                    (value) {
                      if (value.isNotEmpty) {
                        widget.exercises[widget.index].restTimeInSeconds =
                            int.parse(value);
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
      ),
    );
  }

  Widget _buildInputField(double width, String label,
      TextEditingController controller, Function(String) onChanged) {
    return SizedBox(
      width: width,
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
          contentPadding: const EdgeInsets.only(bottom: 14, left: 4, right: 4),
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
    );
  }

  void removeExercise() {
    widget.onRemoveItem.call();
  }
}
