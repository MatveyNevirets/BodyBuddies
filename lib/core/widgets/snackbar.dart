import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String snackBarMessage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colours.workout_card_background_color,
    content: Text(
      snackBarMessage,
      style: Styles.medium_dark_boxes_text,
    ),
    duration: const Duration(milliseconds: 1500),
  ));
}
