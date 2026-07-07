import 'package:body_buddies/core/themes/colors.dart';
import 'package:flutter/material.dart';

BottomNavigationBarItem baseBottomNavigationBarItem(IconData iconData, String? labelText) {
  return BottomNavigationBarItem(icon: Icon(iconData), label: "", backgroundColor: Colours.bottom_bar_icons_color);
}