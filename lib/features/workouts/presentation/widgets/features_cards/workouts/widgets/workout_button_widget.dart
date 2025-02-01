import 'package:flutter/material.dart';

import '../../../../../../../core/colors/colors.dart';
import '../../../../../../../core/strings/strings.dart';
import '../../../../../../../core/styles/styles.dart';

class WorkoutButtonWidget extends StatelessWidget
{
  final VoidCallback onPressed;
  final Size buttonSize;

  const WorkoutButtonWidget(this.onPressed, this.buttonSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(
            Colours.white_text_color),
        foregroundColor:
        WidgetStatePropertyAll(Colours.workoutTextColor),
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
            Strings.start,
            style: Styles.workouts_button_text_style,
          ),
        ],
      ),
    );
  }
}