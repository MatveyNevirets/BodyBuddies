import 'package:body_buddies/core/themes/themes.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/themes/colors.dart';

class ExerciseCardWidget extends StatelessWidget {
  final String text;

  const ExerciseCardWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Адаптивные размеры
    final double horizontalMargin =
        screenWidth * 0.02 > 8 ? 8 : screenWidth * 0.02;
    const double verticalMargin = 4.0;
    final double iconSize =
        screenHeight * 0.045 > 36 ? 36 : screenHeight * 0.045;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin, vertical: verticalMargin),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: DarkTheme.surface,
        border: Border.all(
          color: DarkTheme.divider,
          width: 1,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1F2533), // на 5% светлее DarkTheme.surface
            DarkTheme.surface,
          ],
          stops: [0.0, 0.05],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Иконка вместо PNG (календарь)
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              color: DarkTheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.calendar_today_rounded,
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
          // Маленькая стрелка-намёк (опционально, для визуального якоря)
          Icon(
            Icons.arrow_forward_rounded,
            color: DarkTheme.primary.withOpacity(0.2),
            size: 18,
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
