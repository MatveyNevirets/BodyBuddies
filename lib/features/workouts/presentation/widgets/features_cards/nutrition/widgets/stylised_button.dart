// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/styles/styles.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/colors/colors.dart';

class StylisedButton extends StatelessWidget {
  final bool isElevated;
  final Color? backgroundColor;
  final Color? color;
  final double? elevation;
  final String title;
  final Size? buttonSize;
  final TextStyle? textStyle;
  final CrossAxisAlignment? crossAxisAlignment;
  String? subTitle;

  final VoidCallback? onPressed;

  StylisedButton(
    this.buttonSize,
    this.crossAxisAlignment,
    this.textStyle,
    this.isElevated,
    this.backgroundColor,
    this.color,
    this.elevation,
    this.title,
    this.subTitle,
    this.onPressed, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    if (isElevated && subTitle != null) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
              backgroundColor ?? Colours.white_text_color),
          foregroundColor:
              WidgetStatePropertyAll(color ?? Colours.green_text_color),
          elevation: WidgetStatePropertyAll(elevation ?? 8),
          minimumSize: WidgetStatePropertyAll(
            buttonSize ?? const Size(163, 72 / 1.25),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textStyle ?? Styles.nutrition_text_style,
            ),
            Text(subTitle!, style: textStyle ?? Styles.nutrition_text_style),
          ],
        ),
      );
    } else if (isElevated && subTitle == null) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
              backgroundColor ?? Colours.white_text_color),
          foregroundColor:
              WidgetStatePropertyAll(color ?? Colours.green_text_color),
          elevation: WidgetStatePropertyAll(elevation ?? 72),
          minimumSize: WidgetStatePropertyAll(
            buttonSize ?? const Size(163, 72 / 1.25),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textStyle ?? Styles.nutrition_text_style,
            ),
          ],
        ),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(
              buttonSize ?? const Size(90, 50),
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
        child: Text(
          title,
          style: textStyle ?? Styles.nutrition_text_style,
        ),
      );
    }
  }
}
