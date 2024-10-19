import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback onClick;
  final String buttonText;
  final Color? backgroundColor;
  final Color? textColor;

  bool isElevated = true;

  final IconData? icon;

  BaseButton(
      {required this.onClick,
      required this.buttonText,
      required this.icon,
        required this.backgroundColor,
        required this.textColor,
      required this.isElevated});

  @override
  Widget build(BuildContext context) {
    if (isElevated) {
      if (icon != null) {
        return ElevatedButton(
          onPressed: onClick,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: Styles.base_text_button_style,
              ),
              const SizedBox(
                width: 20,
              ),
              Icon(
                icon,
                color: Colours.base_button_text_color,
              ),
            ],
          ),
          style: Styles.base_button_style,
        );
      } else {
        return ElevatedButton(
          onPressed: onClick,
          child: Text(
            buttonText,
            style: Styles.base_text_button_style,
          ),
          style: Styles.base_button_style,
        );
      }
    } else {
      if (icon != null) {
        return OutlinedButton(
          onPressed: onClick,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: TextStyle(
                    fontSize: 12,
                    color: textColor ?? Colours.base_button_color,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 20,
              ),
              Icon(
                icon,
                color: Colours.base_button_text_color,
              ),
            ],
          ),
          style: Styles.base_outlined_button_style,
        );
      } else {
        return OutlinedButton(
          onPressed: onClick,
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 12,
                color: textColor ?? Colours.base_button_color,
                fontWeight: FontWeight.w500),
          ),
          style: ButtonStyle(
              side: WidgetStatePropertyAll(BorderSide(
                  color: backgroundColor ?? Colours.base_button_color, width: 1.5, style: BorderStyle.solid))),
        );
      }
    }
  }
}
