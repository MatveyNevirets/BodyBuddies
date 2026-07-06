import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String snackBarMessage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colours.workout_card_background_color,
    content: Text(
      snackBarMessage,
      style: DarkTheme.medium_dark_boxes_text,
    ),
    duration: const Duration(milliseconds: 1500),
  ));
}
