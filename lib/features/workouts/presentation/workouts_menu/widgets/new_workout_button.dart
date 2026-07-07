import 'package:flutter/material.dart';

import '../../../../../core/themes/colors.dart';
import '../../../../../../core/strings/strings.dart';
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
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).focusColor,
        ),
        foregroundColor: const WidgetStatePropertyAll(Colours.white_text_color),
        minimumSize: WidgetStatePropertyAll(
          buttonSize,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: DarkTheme.workout_text_style_week_day,
          ),
        ],
      ),
    );
  }
}
