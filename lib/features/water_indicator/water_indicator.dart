import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/water_indicator/water_entity.dart';
import 'package:flutter/material.dart';

class WaterIndicator extends StatelessWidget {
  // 8 стаканов по 250 мл = 2 литра
  final List<WaterEntity> waterCups =
      List.generate(8, (index) => WaterEntity(index));

  WaterIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Заголовок: иконка, "Вода", 2 л
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: DarkTheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '2 л',
                style: TextStyle(
                  color: DarkTheme.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Сетка стаканов: 2 строки по 4
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 12,
          children: waterCups,
        ),
      ],
    );
  }
}
