import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';

abstract class Styles
{
  ///margins/////
  static final base_magrin_size = EdgeInsets.all(16);

  ///elevations//////
  static final double base_elevation = 8;

  ///text//styles/////////
  static final title_text_style = TextStyle(fontSize: 24, color: Colours.white_text_color, fontWeight: FontWeight.bold);
  static final body_text_style = TextStyle(fontSize: 21, color: Colours.black_text_color, fontWeight: FontWeight.w600);

  ///button//styles////////
  static final base_button_style = ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colours.base_button_color));
  static final base_text_button_style = TextStyle(color: Colours.base_button_text_color);
}