// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/colors/colors.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback onClick;
  final String buttonText;

  final Color? backgroundColor;
  final Color? color;
  final double? radius;

  final Size? buttonSize;

  bool isElevated = true;

  final IconData? icon;

  BaseButton(
      {super.key,
      required this.onClick,
      required this.buttonText,
      required this.icon,
      required this.isElevated,
      this.buttonSize,
      this.radius,
      this.backgroundColor,
      this.color});

  @override
  Widget build(BuildContext context) {
    if (isElevated) {
      if (icon != null) {
        return ElevatedButton(
          onPressed: onClick,
          style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(
              buttonSize,
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 32),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(
                backgroundColor ?? Colours.base_button_color),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: TextStyle(
                  color: color ?? Colours.base_button_text_color,
                  fontFamily: 'AqumTwo',
                ),
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
              minimumSize: WidgetStatePropertyAll(
                buttonSize,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 32),
                ),
              ),
              backgroundColor: WidgetStatePropertyAll(
                  backgroundColor ?? Colours.base_button_color)),
          child: Text(
            buttonText,
            style: TextStyle(
                fontFamily: 'AqumTwo',
                color: color ?? Colours.base_button_text_color),
          ),
        );
      }
    } else {
      if (icon != null) {
        return OutlinedButton(
          onPressed: onClick,
          style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(
                buttonSize,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 32),
                ),
              ),
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
                    fontFamily: 'AqumTwo',
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
              minimumSize: WidgetStatePropertyAll(
                buttonSize,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 32),
                ),
              ),
              side: WidgetStatePropertyAll(BorderSide(
                  color: backgroundColor ?? Colours.base_button_color,
                  width: 1.5,
                  style: BorderStyle.solid))),
          child: Text(
            buttonText,
            style: TextStyle(
                fontFamily: 'AqumTwo',
                fontSize: 12,
                color: color ?? Colours.base_button_color,
                fontWeight: FontWeight.w500),
          ),
        );
      }
    }
  }
}
