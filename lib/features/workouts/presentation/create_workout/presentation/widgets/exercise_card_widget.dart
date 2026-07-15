import 'package:body_buddies/core/themes/themes.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/themes/colors.dart';

class ExerciseCardWidget extends StatelessWidget {
  final String text;

  const ExerciseCardWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final double iconSize =
        screenHeight * 0.045 > 36 ? 36 : screenHeight * 0.045;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: DarkTheme.divider,
          width: 1,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1E2330), // на 3-4% светлее surface
            DarkTheme.surface,
          ],
        ),
      ),
      child: Row(
        children: [
          // Иконка упражнения (гантель)
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              color: DarkTheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.fitness_center_rounded,
              color: DarkTheme.primary.withOpacity(0.6),
              size: iconSize * 0.5,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              truncateText(text, 20),
              style: const TextStyle(
                fontFamily: 'Inter',
                color: DarkTheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}
