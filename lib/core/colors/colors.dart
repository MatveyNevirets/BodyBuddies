// ignore_for_file: constant_identifier_names, duplicate_ignore

import 'package:flutter/material.dart';

abstract class Colours {
  ///bars/////
  // ignore: constant_identifier_names
  static const Color bottom_bar_icons_color = Color.fromARGB(255, 55, 161, 227);
  // ignore: constant_identifier_names
  static const Color bottom_bar_background_color =
      Color.fromARGB(255, 250, 250, 250);
  // ignore: constant_identifier_names
  static const Color system_bottom_bar_background_color =
      Color.fromARGB(255, 255, 255, 255);

  //News_screen_colors
  static const Color background_news_card_color =
      Color.fromARGB(255, 177, 216, 252);

  ////text////
  static const Color white_text_color = Colors.white;
  static const Color grey_text_color = Color.fromARGB(255, 237, 237, 237);
  static const Color black_text_color = Color.fromARGB(255, 50, 50, 50);
  static const Color green_text_color = Color.fromARGB(255, 9, 222, 9);
  static const Color hint_form_text_color = Color.fromARGB(189, 0, 0, 0);

  static const Color invisible_color = Color.fromARGB(0, 0, 0, 0);

  /////buttons/////
  static const Color base_button_color = Color.fromARGB(255, 107, 169, 232);
  static const Color base_button_text_color =
      Color.fromARGB(255, 255, 255, 255);

  /////container gradients///////

  static const List<Color> blueContainerGradientColors = [
    Color.fromARGB(255, 120, 166, 211),
    Color.fromARGB(255, 93, 143, 209),
  ];

  static const List<Color> greenContainerGradientColors = [
    Color.fromARGB(255, 41, 228, 54),
    Color.fromARGB(255, 57, 170, 31),
  ];

  static const List<Color> yellowContainerGradientColors = [
    Color.fromARGB(255, 228, 219, 41),
    Color.fromARGB(255, 170, 151, 31),
  ];

  static const List<Color> redContainerGradientColors = [
    Color.fromARGB(255, 228, 41, 41),
    Color.fromARGB(255, 170, 31, 31),
  ];

  static const List<Color> newsCardGradientColor = [
    Color.fromARGB(255, 103, 181, 230),
    Color.fromARGB(255, 150, 192, 230),
  ];

  static Color workoutTextColor = const Color.fromARGB(255, 35, 74, 165);

  static const Color workout_card_background_color =
      Color.fromARGB(255, 110, 121, 158);
  static const workoutCardForegroundColor =
      const Color.fromARGB(255, 208, 219, 253);

  static var journalGradientColors = [
    const Color.fromARGB(255, 111, 122, 159),
    const Color.fromARGB(255, 20, 23, 34)
  ];
}
