import 'package:flutter/material.dart';

import '../../../../../../core/colors/colors.dart';
import '../../../../../../core/strings/strings.dart';
import '../../../../../../core/styles/styles.dart';

class NewWorkoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Size buttonSize;

  const NewWorkoutButton(this.onPressed, this.buttonSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(Colours.workoutCardForegroundColor),
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
            Strings.start2,
            style: Styles.workout_text_style_week_day,
          ),
        ],
      ),
    );
  }
}
