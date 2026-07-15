// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../../../core/themes/themes.dart';

class WorkoutContainerText extends StatelessWidget {
  final String title;
  final double? padding;

  const WorkoutContainerText(this.title, this.padding, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1, // Концепт: тонкая граница 1px
          color: DarkTheme.primary, // Концепт: металлический акцент
        ),
        borderRadius: BorderRadius.circular(12), // Концепт: radius 12
      ),
      padding: EdgeInsets.all(padding ?? 8), // Концепт: базовый шаг 8px
      child: Center(
        child: Text(
          title,
          style: DarkTheme.workouts_containers_text_style,
        ),
      ),
    );
  }
}