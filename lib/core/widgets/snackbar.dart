// lib/core/widgets/snackbar.dart
import 'package:body_buddies/core/themes/themes.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      backgroundColor: DarkTheme.surface, // фон плитки
      elevation: 0, // без теней (концепт)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // радиус из концепта
        side: const BorderSide(
          color: DarkTheme.divider, // тонкий разделитель
          width: 1,
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(
          color: DarkTheme.primary, // основной светлый текст
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}
