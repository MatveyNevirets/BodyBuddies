import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';

abstract class Styles {
  ///margins/////
  static const base_magrin_size = EdgeInsets.all(16);

  ///elevations//////
  static const double base_elevation = 8;

  ///text//styles/////////
  static const appbar_text_style = TextStyle(
      fontSize: 24,
      color: Colours.white_text_color,
      fontWeight: FontWeight.bold);
  static const body_text_style = TextStyle(
      fontSize: 21,
      color: Colours.black_text_color,
      fontWeight: FontWeight.w500);

  static const title_text_style = TextStyle(
      fontSize: 24,
      color: Colours.black_text_color,
      fontWeight: FontWeight.w500);
  static const medium_text_style = TextStyle(
      fontSize: 18,
      color: Colours.black_text_color,
      fontWeight: FontWeight.w400);

  static const outlined_button_text_style = TextStyle(
      fontSize: 12,
      color: Colours.base_button_color,
      fontWeight: FontWeight.w500);

  static const hint_text_style = TextStyle(
      fontSize: 12,
      color: Colours.hint_form_text_color,
      fontWeight: FontWeight.w400);

  static const mini_info_text_style = TextStyle(fontSize: 12,
      color: Colours.black_text_color,
      fontWeight: FontWeight.w200);

  ///button//styles////////
  static const base_button_style = ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colours.base_button_color));

  static const base_outlined_button_style = ButtonStyle(
      side: WidgetStatePropertyAll(BorderSide(
          color: Colours.base_button_color, width: 1.5, style: BorderStyle.solid)));

  static const base_text_button_style =
      TextStyle(color: Colours.base_button_text_color);


}
