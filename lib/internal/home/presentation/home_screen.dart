// lib/internal/home/presentation/home_screen.dart
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import '../../../core/strings/strings.dart';
import '../../../features/useful/useful_feature_card/presentation/useful_feature_card.dart';
import '../../../features/water_indicator_widget/water_indicator_widget.dart';
import '../../../features/workouts/presentation/workout_feature_card/presentation/workouts_feature_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color _bg = Color(0xFF07131F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: createAppBarWidget(
        appbarTitle: Strings.workouts_appbar,
        context: context,
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: _HomeBackground()),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                const _SectionHeader(
                  title: 'Тренировки',
                  subtitle:
                      'Быстрый доступ к программе и запуску текущего плана',
                ),
                const SizedBox(height: 12),
                const WorkoutFeatureCard(),
                const SizedBox(height: 22),
                const _SectionHeader(
                  title: 'Вода',
                  subtitle: 'Отслеживание привычки без лишнего шума',
                ),
                const SizedBox(height: 12),
                Center(
                  child: WaterIndicatorWidget(),
                ),
                const SizedBox(height: 22),
                const _SectionHeader(
                  title: 'Полезное',
                  subtitle:
                      'Инструменты и материалы, которые помогают двигаться быстрее',
                ),
                const SizedBox(height: 12),
                const UsefulFeatureCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String primaryLabel;
  final String secondaryLabel;

  const _HeroCard({
    required this.title,
    required this.subtitle,
    required this.primaryLabel,
    required this.secondaryLabel,
  });

  static const Color _surface = Color(0xFF0E1D2D);
  static const Color _surface2 = Color(0xFF12263A);
  static const Color _border = Color(0xFF22405A);
  static const Color _primary = Color(0xFF2F80ED);
  static const Color _accent = Color(0xFFB8D9FF);
  static const Color _textMain = Color(0xFFF5F8FC);
  static const Color _textSecondary = Color(0xFF9BB0C5);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_surface, _surface2],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: _border.withOpacity(0.9), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0xAA04101A),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned(
              right: -24,
              top: -18,
              child: _GeoCircle(
                size: 110,
                color: _primary.withOpacity(0.16),
              ),
            ),
            Positioned(
              left: -18,
              bottom: -28,
              child: _GeoCircle(
                size: 96,
                color: _accent.withOpacity(0.08),
              ),
            ),
            Positioned(
              right: 26,
              bottom: 18,
              child: Container(
                width: 110,
                height: 3,
                decoration: BoxDecoration(
                  color: _primary.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _HeroBadge(
                        label: primaryLabel,
                        borderColor: _primary.withOpacity(0.45),
                        textColor: _accent,
                        fillColor: _primary.withOpacity(0.14),
                      ),
                      const SizedBox(width: 10),
                      _HeroBadge(
                        label: secondaryLabel,
                        borderColor: _border,
                        textColor: _textSecondary,
                        fillColor: Colors.white.withOpacity(0.03),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text(
                    title,
                    style: const TextStyle(
                      color: _textMain,
                      fontSize: 30,
                      height: 1.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 14.5,
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  final String label;
  final Color borderColor;
  final Color textColor;
  final Color fillColor;

  const _HeroBadge({
    required this.label,
    required this.borderColor,
    required this.textColor,
    required this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
  });

  static const Color _textMain = Color(0xFFF5F8FC);
  static const Color _textSecondary = Color(0xFF9BB0C5);
  static const Color _accent = Color(0xFF7EA8D8);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: _accent,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: _textMain,
              fontSize: 19,
              fontWeight: FontWeight.w800,
              height: 1.08,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 58,
            height: 3,
            decoration: BoxDecoration(
              color: _textSecondary.withOpacity(0.25),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ],
      ),
    );
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

class _HomeBackground extends StatelessWidget {
  const _HomeBackground();

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: CustomPaint(
        painter: _HomeBackgroundPainter(),
        child: SizedBox.expand(),
      ),
    );
  }
}

class _HomeBackgroundPainter extends CustomPainter {
  const _HomeBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF07131F);
    canvas.drawRect(Offset.zero & size, bgPaint);

    final circles = <_PainterCircle>[
      _PainterCircle(
        offset: Offset(size.width * 0.88, size.height * 0.08),
        radius: size.width * 0.26,
        color: const Color(0xFF2F80ED).withOpacity(0.10),
      ),
      _PainterCircle(
        offset: Offset(size.width * 0.08, size.height * 0.18),
        radius: size.width * 0.20,
        color: const Color(0xFFB8D9FF).withOpacity(0.05),
      ),
      _PainterCircle(
        offset: Offset(size.width * 0.72, size.height * 0.48),
        radius: size.width * 0.18,
        color: const Color(0xFF1F5FBF).withOpacity(0.08),
      ),
    ];

    for (final circle in circles) {
      final paint = Paint()..color = circle.color;
      canvas.drawCircle(circle.offset, circle.radius, paint);
    }

    final linePaint = Paint()
      ..color = const Color(0xFF4A9BFF).withOpacity(0.10)
      ..strokeWidth = 1.2;

    for (double y = 110; y < size.height; y += 130) {
      canvas.drawLine(
          Offset(0, y), Offset(size.width * 0.92, y + 16), linePaint);
    }

    final bandPaint = Paint()
      ..color = const Color(0xFF12263A).withOpacity(0.65);
    final bandPath = Path()
      ..moveTo(size.width * 0.58, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.34)
      ..close();
    canvas.drawPath(bandPath, bandPaint);

    final band2Paint = Paint()
      ..color = const Color(0xFF0E1D2D).withOpacity(0.65);
    final band2Path = Path()
      ..moveTo(0, size.height * 0.76)
      ..lineTo(size.width * 0.55, size.height * 0.62)
      ..lineTo(size.width * 0.74, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(band2Path, band2Paint);

    final gridPaint = Paint()
      ..color = const Color(0xFF244055).withOpacity(0.16)
      ..strokeWidth = 0.8;

    const step = 42.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PainterCircle {
  final Offset offset;
  final double radius;
  final Color color;

  const _PainterCircle({
    required this.offset,
    required this.radius,
    required this.color,
  });
}
