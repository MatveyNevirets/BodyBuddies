import 'package:flutter/material.dart';

import '../../../../../../core/strings/strings.dart';
import '../../../../../../core/themes/themes.dart';

class WorkoutButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Size buttonSize;

  const WorkoutButtonWidget(this.onPressed, this.buttonSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        // Концепт: фон = Primary Accent, тень почти отсутствует
        backgroundColor: const WidgetStatePropertyAll(DarkTheme.primary),
        foregroundColor: const WidgetStatePropertyAll(DarkTheme.background),
        elevation: const WidgetStatePropertyAll(0),
        minimumSize: WidgetStatePropertyAll(buttonSize),
        // Концепт: radius 14
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      child: Text(
        Strings.start,
        // Концепт: текст = цвет фона, соблюдаем типографику кнопок
        style: DarkTheme.workouts_button_text_style.copyWith(
          color: DarkTheme.background,
        ),
      ),
    );
  }
}
