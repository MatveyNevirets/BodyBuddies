import 'package:flutter/material.dart';

import '../../../../../core/strings/strings.dart';
import '../../../../../core/themes/themes.dart';

class NewWorkoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Size buttonSize;
  final String title;

  const NewWorkoutButton(this.onPressed, this.buttonSize,
      {super.key, this.title = Strings.start2});

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
        title,
        // Концепт: типографика кнопок (вес 600, размер 16)
        style: DarkTheme.workouts_button_text_style.copyWith(
          color: DarkTheme.background,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
