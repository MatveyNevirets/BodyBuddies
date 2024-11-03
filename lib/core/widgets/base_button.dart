// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/colors/colors.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback onClick;
  final String buttonText;

  final Color? backgroundColor;
  final Color? color;

  bool isElevated = true;

  final IconData? icon;

  BaseButton(
      {super.key, required this.onClick,
      required this.buttonText,
      required this.icon,
      required this.isElevated,
      this.backgroundColor,
      this.color,});

  @override
  Widget build(BuildContext context) {
    if (isElevated) {
      if (icon != null) {
        return ElevatedButton(
          onPressed: onClick,
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                  backgroundColor ?? Colours.base_button_color)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style:
                    TextStyle(color: color ?? Colours.base_button_text_color),
              ),
              const SizedBox(
                width: 20,
              ),
              Icon(
                icon,
                color: color ?? Colours.base_button_text_color,
              ),
            ],
          ),
        );
      } else {
        return ElevatedButton(
          onPressed: onClick,
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                  backgroundColor ?? Colours.base_button_color)),
          child: Text(
            buttonText,
            style: TextStyle(color: color ?? Colours.base_button_text_color),
          ),
        );
      }
    } else {
      if (icon != null) {
        return OutlinedButton(
          onPressed: onClick,
          style: ButtonStyle(
              side: WidgetStatePropertyAll(BorderSide(
                  color: backgroundColor ?? Colours.base_button_color,
                  width: 1.5,
                  style: BorderStyle.solid))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: TextStyle(
                    fontSize: 12,
                    color: color ?? Colours.base_button_color,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 20,
              ),
              Icon(
                icon,
                color: color ?? Colours.base_button_text_color,
              ),
            ],
          ),
        );
      } else {
        return OutlinedButton(
          onPressed: onClick,
          style: ButtonStyle(
              side: WidgetStatePropertyAll(BorderSide(
                  color: backgroundColor ?? Colours.base_button_color,
                  width: 1.5,
                  style: BorderStyle.solid))),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 12,
                color: color ?? Colours.base_button_color,
                fontWeight: FontWeight.w500),
          ),
        );
      }
    }
  }
}
