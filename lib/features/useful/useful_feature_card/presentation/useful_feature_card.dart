// lib/features/useful/useful_feature_card/presentation/useful_feature_card.dart
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:flutter/material.dart';

import '../../../../core/strings/strings.dart';

class UsefulFeatureCard extends StatelessWidget {
  const UsefulFeatureCard({super.key, required this.isConnection});

  final bool isConnection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _FeatureTile(
                imagePath: "assets/images/bench_press_calculator_background.png",
                title: Strings.calculator,
                subtitle: Strings.bench_presses,
                onTap: () => _openPage(context, "/bench_press_calculator"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _FeatureTile(
                imagePath: "assets/images/advice_background.png",
                title: Strings.advices,
                subtitle: Strings.beginners,
                onTap: () => _openPage(context, "/advices"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _FeatureTile(
          imagePath: "assets/images/done_workouts_background.png",
          title: "Готовые программы",
          subtitle: "Тренировки, которые можно открыть сразу",
          fullWidth: true,
          onTap: () => _tryOpenDoneWorkouts(context, "/made_workouts"),
        ),
      ],
    );
  }

  void _openPage(BuildContext context, String routePath) {
    Navigator.of(context).pushNamed(routePath);
  }

  void _tryOpenDoneWorkouts(BuildContext context, String routePath) {
    if (isConnection) {
      Navigator.of(context).pushNamed(routePath);
    } else {
      showSnackBar(context, Strings.haventInternetConnetion);
    }
  }
}

class _FeatureTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool fullWidth;

  const _FeatureTile({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    // Высота карточки – фиксированная, как раньше minHeight
    final double cardHeight = fullWidth ? 168.0 : 152.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: cardHeight, // теперь строго заданная высота
          decoration: BoxDecoration(
            color: DarkTheme.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: DarkTheme.divider, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              // Убрали fit: StackFit.expand – размер уже определён родителем
              children: [
                // Фоновое изображение
                Positioned.fill(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                // Затемняющий слой
                Positioned.fill(
                  child: Container(
                    color: DarkTheme.background.withOpacity(0.65),
                  ),
                ),
                // Иконка стрелки
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: DarkTheme.surface.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: DarkTheme.divider,
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_outward_rounded,
                      color: DarkTheme.primary,
                      size: 18,
                    ),
                  ),
                ),
                // Текстовый блок
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: DarkTheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        maxLines: fullWidth ? 2 : 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: DarkTheme.secondary,
                          fontSize: 12,
                          height: 1.25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}