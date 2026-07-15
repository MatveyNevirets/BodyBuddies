// ignore_for_file: constant_identifier_names, unnecessary_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class DarkTheme {
  /// =========================
  /// CORE COLORS (из концепта)
  /// =========================

  // Background
  static const Color background = Color(0xFF0F1115);
  static const Color backgroundSecondary = Color(0xFF151922);

  // Surface (карточки)
  static const Color surface = Color(0xFF1A1F2B);

  // Accents
  static const Color primary = Color(0xFFD6D9DF);
  static const Color secondary = Color(0xFF6C768A);

  // Actions
  static const Color white = Color(0xFFFFFFFF);

  // Divider
  static const Color divider = Color(0xFF232838);

  /// =========================
  /// SPACING / SYSTEM
  /// =========================

  static const base_margin_size = EdgeInsets.all(16);
  static double base_margin_size_double = 16;
  static double base_padding_size_double = 2;

  static const double base_elevation = 0; // почти отсутствует (по концепту)

  static const double height_of_text_to_widget = 8;
  static const double big_height_of_text_to_widget = 32;

  /// =========================
  /// TYPOGRAPHY
  /// =========================

  static const appbar_text_style = TextStyle(
    fontSize: 20,
    color: primary,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static const appbar_text_style_dark_theme = TextStyle(
    fontSize: 20,
    color: primary,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static const body_text_style = TextStyle(
    fontSize: 16,
    color: primary,
    fontWeight: FontWeight.w500,
    height: 1.35,
  );

  static var hint_text_style_create_workout = const TextStyle(
    fontSize: 16,
    color: secondary,
    fontWeight: FontWeight.w500,
  );

  static var hint_text_style_create_exercise = const TextStyle(
    fontSize: 16,
    color: secondary,
    fontWeight: FontWeight.w500,
  );

  static var hint_text_field_fill_workout = const TextStyle(
    fontSize: 12,
    color: secondary,
    fontWeight: FontWeight.w400,
  );

  static var reverse_rest_text_style = const TextStyle(
    fontSize: 18,
    color: primary,
    fontWeight: FontWeight.w700,
  );

  static var workouts_containers_text_style = const TextStyle(
    fontSize: 12,
    color: primary,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );

  static var advices_containers_text_style = const TextStyle(
    fontSize: 14,
    color: primary,
    fontWeight: FontWeight.w600,
  );

  static var news_card_header_text_style = const TextStyle(
    fontSize: 18,
    color: primary,
    fontWeight: FontWeight.w700,
  );

  static var news_card_body_text_style = const TextStyle(
    fontSize: 12,
    color: secondary,
    fontWeight: FontWeight.w400,
  );

  static const medium_dark_boxes_text = TextStyle(
    fontSize: 18,
    color: primary,
    fontWeight: FontWeight.w500,
  );

  static const small_dark_boxes_text_dark_theme = TextStyle(
    fontSize: 12,
    color: secondary,
    fontWeight: FontWeight.w500,
  );

  static const small_dark_boxes_text = TextStyle(
    fontSize: 12,
    color: secondary,
    fontWeight: FontWeight.w500,
  );

  static const title_text_style = TextStyle(
    fontSize: 28,
    color: primary,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static const title_blue_text_style = TextStyle(
    fontSize: 28,
    color: primary,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static const body_blue_text_style = TextStyle(
    fontSize: 18,
    color: primary,
    fontWeight: FontWeight.w600,
  );

  static const medium_text_style = TextStyle(
    fontSize: 18,
    color: primary,
    fontWeight: FontWeight.w400,
  );

  static const outlined_button_text_style = TextStyle(
    fontSize: 14,
    color: primary,
    fontWeight: FontWeight.w600,
  );

  static const hint_text_style = TextStyle(
    fontSize: 12,
    color: secondary,
    fontWeight: FontWeight.w400,
  );

  static const mini_info_text_style = TextStyle(
    fontSize: 12,
    color: secondary,
    fontWeight: FontWeight.w400,
  );

  /// =========================
  /// BUTTONS (по концепту)
  /// =========================

  static final base_button_style = ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll(primary),
    foregroundColor: const WidgetStatePropertyAll(background),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(vertical: 16),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );

  static final base_outlined_button_style = ButtonStyle(
    side: const WidgetStatePropertyAll(
      BorderSide(
        color: divider,
        width: 1,
      ),
    ),
    foregroundColor: const WidgetStatePropertyAll(primary),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );

  static const base_text_button_style = TextStyle(
    color: secondary,
  );

  /// =========================
  /// OTHER
  /// =========================

  static var nutrition_text_style = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: secondary,
  );

  static var nutrition_symbol_text_style = const TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w700,
    color: primary,
  );

  static var workout_text_style = const TextStyle(
    fontSize: 21,
    color: primary,
    fontWeight: FontWeight.w700,
  );

  static var workout_text_style_dark_theme = const TextStyle(
    fontSize: 21,
    color: primary,
    fontWeight: FontWeight.w700,
  );

  static var add_exercise_text_style = const TextStyle(
    fontSize: 18,
    color: primary,
    fontWeight: FontWeight.w600,
  );

  static var workout_text_style_week_day = const TextStyle(
    fontSize: 14,
    color: secondary,
    fontWeight: FontWeight.w600,
  );

  static var workout_exercise_card_style = const TextStyle(
    fontSize: 12,
    color: primary,
    fontWeight: FontWeight.w500,
  );

  static var workout_text_style_background_24 = const TextStyle(
    fontSize: 24,
    color: primary,
    fontWeight: FontWeight.w700,
  );

  static var workout_text_style2 = const TextStyle(
    fontSize: 12,
    color: primary,
    fontWeight: FontWeight.w500,
  );

  static var mini_hint_background = const TextStyle(
    fontSize: 16,
    color: secondary,
    fontWeight: FontWeight.w500,
  );

  static var mini_journal_card_text = const TextStyle(
    fontSize: 14,
    color: primary,
    fontWeight: FontWeight.w600,
  );

  static var mini_journal_card_text2 = const TextStyle(
    fontSize: 14,
    color: primary,
    fontWeight: FontWeight.w600,
  );

  static var mini_current_card_text = const TextStyle(
    fontSize: 12,
    color: secondary,
    fontWeight: FontWeight.w500,
  );

  static var mini_current_card_text2 = const TextStyle(
    fontSize: 12,
    color: primary,
    fontWeight: FontWeight.w500,
  );

  static double nutrition_button_elevate = 0;

  static var workouts_button_text_style = const TextStyle(
    fontSize: 12,
    color: primary,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle loadingTextStyle = TextStyle(
    fontSize: 24,
    color: primary,
    fontWeight: FontWeight.w700,
  );
}
