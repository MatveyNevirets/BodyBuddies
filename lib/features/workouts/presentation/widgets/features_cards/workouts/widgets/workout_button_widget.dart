import 'package:flutter/material.dart';

import '../../../../../../../core/colors/colors.dart';
import '../../../../../../../core/strings/strings.dart';
import '../../../../../../../core/styles/styles.dart';

class WorkoutButtonWidget extends StatelessWidget
{
  final VoidCallback onPressed;
  final Size buttonSize;

  WorkoutButtonWidget(this.onPressed, this.buttonSize);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
            Colours.white_text_color),
        foregroundColor:
        WidgetStatePropertyAll(Colours.workout_text_color),
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