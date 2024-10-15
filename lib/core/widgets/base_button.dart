import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback onClick;
  final String buttonText;

  bool isElevated = true;

  final IconData? icon;

  BaseButton(
      {required this.onClick,
      required this.buttonText,
      required this.icon,
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
              SizedBox(
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
                style: Styles.outlined_button_text_style,
              ),
              SizedBox(
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
            style: Styles.outlined_button_text_style,
          ),
          style: Styles.base_outlined_button_style,
        );
      }
    }
  }
}
