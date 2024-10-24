// ignore_for_file: constant_identifier_names, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';

abstract class Styles {
  ///margins/////
  static const base_margin_size = EdgeInsets.all(16);
  static double base_margin_size_double = 16;

  ///elevations//////
  static const double base_elevation = 8;

  ///Sized/boxes//////
  static const double height_of_text_to_widget = 10;
  static const double big_height_of_text_to_widget = 45;

  ///text//styles/////////
  static const appbar_text_style = TextStyle(
      fontSize: 24,
      color: Colours.black_text_color,
      fontWeight: FontWeight.bold);
  static const body_text_style = TextStyle(
      fontSize: 21,
      color: Colours.black_text_color,
      fontWeight: FontWeight.w500);

  ////dark///boxes//////

  static const medium_dark_boxes_text = TextStyle(
      fontSize: 18,
      color: Colours.white_text_color,
      fontWeight: FontWeight.w500);

  static const small_dark_boxes_text = TextStyle(
      fontSize: 12,
      color: Colours.grey_text_color,
      fontWeight: FontWeight.w400);

  ////dark///boxes//////
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

  static var nutrition_text_style = TextStyle(fontFamily: 'AqumTwo', fontSize: 12);
  static var nutrition_symbol_text_style = TextStyle(fontFamily: 'AqumTwo', fontSize: 21);

  static double nutrition_button_elevate = 72;



}
