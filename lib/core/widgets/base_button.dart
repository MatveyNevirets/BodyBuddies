import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback onClick;
  final String buttonText;

  final IconData? icon;

  BaseButton({required this.onClick, required this.buttonText, required this.icon});

  @override
  Widget build(BuildContext context) {
    if(icon != null) {
      return ElevatedButton(
        onPressed: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: Styles.base_text_button_style,
            ),
            SizedBox(width: 20,),
            Icon(icon, color: Colours.base_button_text_color,),
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
  }
}
