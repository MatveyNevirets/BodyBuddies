import 'package:body_buddies/core/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/colors/colors.dart';

class StylisedButton extends StatelessWidget {
  final bool isElevated;
  final Color? backgroundColor;
  final Color? color;
  final double? elevation;
  final String title;
  String? subTitle;

  final VoidCallback onPressed;

  StylisedButton(
    this.isElevated,
    this.backgroundColor,
    this.color,
    this.elevation,
    this.title,
    this.subTitle,
    this.onPressed,
  );

  @override
  Widget build(BuildContext context) {
    if (isElevated && subTitle != null) {
      return ElevatedButton(
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Styles.nutrition_text_style,
            ),
            Text(subTitle!, style: Styles.nutrition_text_style),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
              backgroundColor ?? Colours.white_text_color),
          foregroundColor:
              WidgetStatePropertyAll(color ?? Colours.green_text_color),
          elevation: WidgetStatePropertyAll(elevation ?? 8),
          minimumSize: WidgetStatePropertyAll(
            Size(163, 72 / 1.25),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      );
    } else if (isElevated && subTitle == null) {
      return ElevatedButton(
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Styles.nutrition_text_style,
            ),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
              backgroundColor ?? Colours.white_text_color),
          foregroundColor:
              WidgetStatePropertyAll(color ?? Colours.green_text_color),
          elevation: WidgetStatePropertyAll(elevation ?? 72),
          minimumSize: WidgetStatePropertyAll(
            Size(163, 72 / 1.25),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        child: Text(title, style: Styles.nutrition_text_style,),
        style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(
              Size(90, 50),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            side: WidgetStatePropertyAll(BorderSide(
                style: BorderStyle.solid,
                width: 2,
                color: color ?? Colours.white_text_color)),
            backgroundColor: WidgetStatePropertyAll(
                backgroundColor ?? Colours.white_text_color),
            foregroundColor:
                WidgetStatePropertyAll(color ?? Colours.green_text_color),
            elevation: WidgetStatePropertyAll(elevation ?? 72)),
      );
    }
  }
}
