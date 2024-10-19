import 'package:body_buddies/core/colors/colors.dart';
import 'package:flutter/material.dart';

BottomNavigationBarItem baseBottomNavigationBarItem(IconData iconData, String? labelText) {
  return BottomNavigationBarItem(icon: Icon(iconData), label: "", backgroundColor: Colours.app_bar_color);
}