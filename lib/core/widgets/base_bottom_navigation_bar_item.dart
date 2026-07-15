import 'package:body_buddies/core/themes/colors.dart';
import 'package:flutter/material.dart';

BottomNavigationBarItem baseBottomNavigationBarItem(
    IconData iconData, String? labelText) {
  return BottomNavigationBarItem(
    icon: Icon(iconData),
    label: "",
  );
}
