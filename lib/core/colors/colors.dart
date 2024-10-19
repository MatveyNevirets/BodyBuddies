import 'dart:ui';

import 'package:flutter/material.dart';

abstract class Colours
{
  ///bars/////
  static const Color bottom_bar_icons_color = Color.fromARGB(255, 55, 161, 227);
  static const Color bottom_bar_background_color = Color.fromARGB(
      255, 250, 250, 250);
  static const Color system_bottom_bar_background_color = Color.fromARGB(
      255, 255, 255, 255);


  ////text////
  static const Color white_text_color = Colors.white;
  static const Color grey_text_color = Color.fromARGB(255, 237, 237, 237);
  static const Color black_text_color = Color.fromARGB(255, 50, 50, 50);

  static const Color hint_form_text_color = Color.fromARGB(189, 0, 0, 0);

  /////buttons/////
  static const Color base_button_color = Color.fromARGB(255, 107, 169, 232);
  static const Color base_button_text_color = Color.fromARGB(255, 255, 255, 255);


  /////container gradients///////



  static const List<Color> blueContainerGradientColors = [
    Color.fromARGB(255, 4, 180, 255),
    Color.fromARGB(255, 49, 52, 253),
  ];

  static const List<Color> appBarGradientColors = [
    Color.fromARGB(255, 4, 217, 255),
    Color.fromARGB(255, 115, 172, 220),
  ];
}