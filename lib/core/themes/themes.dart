// lib/core/styles/styles.dart
// ignore_for_file: constant_identifier_names, unnecessary_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';

abstract class DarkTheme {
  static const base_margin_size = EdgeInsets.all(16);
  static double base_margin_size_double = 16;
  static double base_padding_size_double = 2;

  static const double base_elevation = 8;

  static const double height_of_text_to_widget = 10;
  static const double big_height_of_text_to_widget = 45;

  static const appbar_text_style = TextStyle(
    fontSize: 20,
    color: Colours.black_text_color,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.4,
  );

  static const appbar_text_style_dark_theme = TextStyle(
    fontSize: 20,
    color: Colours.white_text_color,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.4,
  );

  static const body_text_style = TextStyle(
    fontSize: 16,
    color: Colours.black_text_color,
    fontWeight: FontWeight.w500,
    height: 1.35,
  );

  static var hint_text_style_create_workout = const TextStyle(
    fontSize: 16,
    color: Colours.workout_card_background_color,
    fontWeight: FontWeight.w600,
  );

  static var hint_text_style_create_exercise = const TextStyle(
    fontSize: 16,
    color: Colours.workoutCardForegroundColor,
    fontWeight: FontWeight.w600,
  );

  static var hint_text_field_fill_workout = const TextStyle(
    fontSize: 12,
    color: Colours.workout_card_background_color,
    fontWeight: FontWeight.w600,
  );

  static var reverse_rest_text_style = const TextStyle(
    fontSize: 18,
    color: Colours.workout_card_background_color,
    fontWeight: FontWeight.w700,
  );

  static var workouts_containers_text_style = const TextStyle(
    fontSize: 12,
    color: Colours.white_text_color,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.8,
  );

  static var advices_containers_text_style = const TextStyle(
    fontSize: 14,
    color: Colours.white_text_color,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.7,
  );

  static var news_card_header_text_style = const TextStyle(
    fontSize: 18,
    color: Colours.black_text_color,
    fontWeight: FontWeight.w800,
  );

  static var news_card_body_text_style = const TextStyle(
    fontSize: 12,
    color: Colours.black_text_color,
    fontWeight: FontWeight.w500,
  );

  static const medium_dark_boxes_text = TextStyle(
    fontSize: 18,
    color: Colours.white_text_color,
    fontWeight: FontWeight.w500,
  );

  static const small_dark_boxes_text_dark_theme = TextStyle(
    fontSize: 12,
    color: Colours.grey_text_color,
    fontWeight: FontWeight.w600,
  );

  static const small_dark_boxes_text = TextStyle(
    fontSize: 12,
    color: Colours.black_text_color,
    fontWeight: FontWeight.w600,
  );

  static const title_text_style = TextStyle(
    fontSize: 24,
    color: Colours.workout_card_background_color,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.4,
  );

  static const title_blue_text_style = TextStyle(
    fontSize: 24,
    color: Colours.workout_card_background_color,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.4,
  );

  static const body_blue_text_style = TextStyle(
    fontSize: 18,
    color: Colours.workout_card_background_color,
    fontWeight: FontWeight.w600,
  );

  static const medium_text_style = TextStyle(
    fontSize: 18,
    color: Colours.black_text_color,
    fontWeight: FontWeight.w400,
  );

  static const outlined_button_text_style = TextStyle(
    fontSize: 12,
    color: Colours.base_button_color,
    fontWeight: FontWeight.w600,
  );

  static const hint_text_style = TextStyle(
    fontSize: 12,
    color: Colours.hint_form_text_color,
    fontWeight: FontWeight.w400,
  );

  static const mini_info_text_style = TextStyle(
    fontSize: 12,
    color: Colours.black_text_color,
    fontWeight: FontWeight.w200,
  );

  static const base_button_style = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colours.base_button_color),
  );

  static const base_outlined_button_style = ButtonStyle(
    side: WidgetStatePropertyAll(
      BorderSide(
        color: Colours.base_button_color,
        width: 1.5,
        style: BorderStyle.solid,
      ),
    ),
  );

  static const base_text_button_style =
      TextStyle(color: Colours.base_button_text_color);

  static var nutrition_text_style = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  static var nutrition_symbol_text_style = const TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w800,
  );

  static var workout_text_style = const TextStyle(
    fontSize: 21,
    color: Colours.black_text_color,
    fontWeight: FontWeight.w800,
  );

  static var workout_text_style_dark_theme = const TextStyle(
    fontSize: 21,
    color: Colours.workoutCardForegroundColor,
    fontWeight: FontWeight.w800,
  );

  static var add_exercise_text_style = const TextStyle(
    fontSize: 18,
    color: Colours.workoutCardForegroundColor,
    fontWeight: FontWeight.w700,
  );

  static var workout_text_style_week_day = const TextStyle(
    fontSize: 14,
    color: Colours.workout_card_background_color,
    fontWeight: FontWeight.w700,
  );

  static var workout_exercise_card_style = const TextStyle(
    fontSize: 12,
    color: Colours.workoutCardForegroundColor,
    fontWeight: FontWeight.w600,
  );

  static var workout_text_style_background_24 = const TextStyle(
    fontSize: 24,
    color: Colours.workout_card_background_color,
    fontWeight: FontWeight.w800,
  );

  static var workout_text_style2 = const TextStyle(
    fontSize: 12,
    color: Colours.white_text_color,
    fontWeight: FontWeight.w600,
  );

  static var mini_hint_background = const TextStyle(
    fontSize: 16,
    color: Colours.workout_card_background_color,
    fontWeight: FontWeight.w700,
  );

  static var mini_journal_card_text = const TextStyle(
    fontSize: 14,
    color: Colours.workout_card_background_color,
    fontWeight: FontWeight.w700,
  );

  static var mini_journal_card_text2 = const TextStyle(
    fontSize: 14,
    color: Colours.workoutCardForegroundColor,
    fontWeight: FontWeight.w700,
  );

  static var mini_current_card_text = const TextStyle(
    fontSize: 12,
    color: Colours.workout_card_background_color,
    fontWeight: FontWeight.w700,
  );

  static var mini_current_card_text2 = const TextStyle(
    fontSize: 12,
    color: Colours.workoutCardForegroundColor,
    fontWeight: FontWeight.w700,
  );

  static double nutrition_button_elevate = 20;

  static var workouts_button_text_style = TextStyle(
    fontSize: 12,
    color: Colours.workoutTextColor,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle loadingTextStyle = TextStyle(
    fontSize: 24,
    color: Colours.bottom_bar_icons_color,
    fontWeight: FontWeight.w800,
  );
}

