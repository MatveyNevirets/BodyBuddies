// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/themes/themes.dart';
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

  BaseButton({
    super.key,
    required this.onClick,
    required this.buttonText,
    required this.icon,
    required this.isElevated,
    this.buttonSize,
    this.radius,
    this.backgroundColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius ?? 14);

    final textStyle = TextStyle(
      color: isElevated
          ? (color ?? DarkTheme.background)
          : (color ?? DarkTheme.primary),
      fontSize: isElevated ? 16 : 12,
      fontWeight: isElevated ? FontWeight.w600 : FontWeight.w500,
      letterSpacing: -0.2,
    );

    final content = icon != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(buttonText, style: textStyle),
              const SizedBox(width: 12),
              Icon(
                icon,
                color: textStyle.color,
                size: 20,
              ),
            ],
          )
        : Text(
            buttonText,
            style: textStyle,
          );

    final baseStyle = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(buttonSize),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      elevation: const WidgetStatePropertyAll(0),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
    );

    if (isElevated) {
      return ElevatedButton(
        onPressed: onClick,
        style: baseStyle.copyWith(
          backgroundColor: WidgetStatePropertyAll(
            backgroundColor ?? DarkTheme.primary,
          ),
          foregroundColor: const WidgetStatePropertyAll(
            DarkTheme.background,
          ),
        ),
        child: content,
      );
    } else {
      return OutlinedButton(
        onPressed: onClick,
        style: baseStyle.copyWith(
          side: WidgetStatePropertyAll(
            BorderSide(
              color: backgroundColor ?? DarkTheme.divider,
              width: 1,
            ),
          ),
        ),
        child: content,
      );
    }
  }
}
