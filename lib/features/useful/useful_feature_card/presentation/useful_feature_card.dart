// lib/features/useful/useful_feature_card/presentation/useful_feature_card.dart
import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/strings/strings.dart';

const Color _surface = Color(0xFF0E1D2D);
const Color _surface2 = Color(0xFF12263A);

class UsefulFeatureCard extends StatelessWidget {
  const UsefulFeatureCard({super.key, required this.isConnection});

  final bool isConnection;

  static const Color _border = Color(0xFF244055);

  static const Color _accent = Color(0xFF2F80ED);
  static const Color _accentSoft = Color(0xFFB8D9FF);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _FeatureTile(
                imagePath:
                    "assets/images/bench_press_calculator_background.png",
                title: Strings.calculator,
                subtitle: Strings.bench_presses,
                accent: _accent,
                accentSoft: _accentSoft,
                border: _border,
                onTap: () => openPage(context, "/bench_press_calculator"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _FeatureTile(
                imagePath: "assets/images/advice_background.png",
                title: Strings.advices,
                subtitle: Strings.beginners,
                accent: const Color(0xFF4A9BFF),
                accentSoft: _accentSoft,
                border: _border,
                onTap: () => openPage(context, "/advices"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _FeatureTile(
          imagePath: "assets/images/done_workouts_background.png",
          title: 'ГОТОВЫЕ ПРОГРАММЫ',
          subtitle: 'Тренировки, которые можно открыть сразу',
          accent: const Color(0xFF2F80ED),
          accentSoft: _accentSoft,
          border: _border,
          fullWidth: true,
          onTap: () => tryOpenDoneWorkouts(context, "/made_workouts"),
        ),
      ],
    );
  }

  void openPage(BuildContext context, String routePath) {
    Navigator.of(context).pushNamed(routePath);
  }

  void tryOpenDoneWorkouts(BuildContext context, String routePath) {
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
  final Color accent;
  final Color accentSoft;
  final Color border;
  final VoidCallback onTap;
  final bool fullWidth;

  const _FeatureTile({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.accentSoft,
    required this.border,
    required this.onTap,
    this.fullWidth = false,
  });

  static const Color _textMain = Color(0xFFF5F8FC);
  static const Color _textSecondary = Color(0xFF9BB0C5);

  @override
  Widget build(BuildContext context) {
    final card = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          constraints: BoxConstraints(
            minHeight: fullWidth ? 176 : 158,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _surface,
                _surface2,
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: border, width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0xAA04101A),
                blurRadius: 18,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.06),
                          Colors.black.withOpacity(0.42),
                          Colors.black.withOpacity(0.78),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -18,
                  top: -22,
                  child: _GeoCircle(
                    size: 86,
                    color: accent.withOpacity(0.16),
                  ),
                ),
                Positioned(
                  right: -20,
                  bottom: -26,
                  child: _GeoCircle(
                    size: 96,
                    color: accentSoft.withOpacity(0.08),
                  ),
                ),
                Positioned(
                  right: 14,
                  top: 14,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: Colors.white.withOpacity(0.12)),
                    ),
                    child: Icon(
                      Icons.arrow_outward_rounded,
                      color: accentSoft,
                      size: fullWidth ? 18 : 17,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: accent.withOpacity(0.14),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: accent.withOpacity(0.28)),
                          ),
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: _textMain,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: fullWidth ? 280 : 140,
                          ),
                          child: Text(
                            subtitle,
                            maxLines: fullWidth ? 2 : 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _textSecondary,
                              fontSize: 13,
                              height: 1.25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return card;
  }
}

class _GeoCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _GeoCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
