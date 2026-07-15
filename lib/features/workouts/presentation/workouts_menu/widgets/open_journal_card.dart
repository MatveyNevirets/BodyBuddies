// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:flutter/material.dart';

class OpenWorkoutsJournal extends StatelessWidget {
  List<ExerciseEntity> emptyList = [];

  OpenWorkoutsJournal({super.key});

  openJournal(BuildContext context) {
    Navigator.of(context).pushNamed("/workouts_menu/workouts_journal/");
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    // Адаптивные размеры
    final double cardHeight =
        screenHeight * 0.22 > 180 ? 180 : screenHeight * 0.22;
    final double horizontalPadding =
        screenWidth * 0.04 > 16 ? 16 : screenWidth * 0.04;
    const double verticalPadding = 16.0;
    final double imageSize = cardHeight * 0.45;

    return GestureDetector(
      onTap: () => openJournal(context),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.0, end: 1.0),
        duration: const Duration(milliseconds: 120),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: Container(
          height: cardHeight,
          margin:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
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
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Фоновая геометрия (асимметрия)
              Positioned.fill(
                child: CustomPaint(
                  painter: _CardBackgroundPainter(
                    primaryColor: DarkTheme.primary,
                    secondaryColor: DarkTheme.secondary,
                  ),
                  size: Size(screenWidth, cardHeight),
                ),
              ),
              // Основной контент
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: verticalPadding),
                child: Row(
                  children: [
                    // Иконка (вместо PNG)
                    Container(
                      height: imageSize,
                      width: imageSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: DarkTheme.primary.withOpacity(0.08),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.fitness_center_rounded,
                          size: imageSize * 0.6,
                          color: DarkTheme.primary.withOpacity(0.6),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Текстовый блок
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Strings.journal,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              letterSpacing: -0.4,
                              color: DarkTheme.primary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            Strings.workouts,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              letterSpacing: -0.4,
                              color: DarkTheme.primary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Посмотреть историю',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: DarkTheme.secondary,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Стрелка (намёк на переход)
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: DarkTheme.primary.withOpacity(0.3),
                      size: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Кастомный художник для фоновой геометрии внутри карточки
class _CardBackgroundPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;

  _CardBackgroundPainter({
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = primaryColor.withOpacity(0.04)
      ..style = PaintingStyle.fill;

    // Диагональный прямоугольник (асимметрия)
    final rect = Rect.fromLTWH(
      size.width * 0.7,
      size.height * 0.1,
      size.width * 0.25,
      size.height * 0.3,
    );
    canvas.drawRect(rect, fillPaint..color = secondaryColor.withOpacity(0.035));

    // Треугольник (разрезанная форма)
    final path = Path()
      ..moveTo(size.width * 0.9, size.height * 0.7)
      ..lineTo(size.width, size.height * 0.7)
      ..lineTo(size.width, size.height * 0.9)
      ..close();
    canvas.drawPath(path, fillPaint..color = primaryColor.withOpacity(0.05));

    // Линия (диагональ)
    final linePaint = Paint()
      ..color = primaryColor.withOpacity(0.04)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.1),
      Offset(size.width * 0.6, size.height * 0.6),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Оставляем старый класс для совместимости (если используется где-то ещё)
class BackgroundGeometryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = DarkTheme.primary.withOpacity(0.05)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = DarkTheme.secondary.withOpacity(0.04)
      ..style = PaintingStyle.fill;

    canvas.drawLine(
      const Offset(0, 0),
      Offset(size.width * 0.4, size.height * 0.4),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height * 0.1),
      Offset(size.width * 0.6, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.2, size.height),
      Offset(size.width, 0),
      paint,
    );

    final path = Path();
    path.moveTo(size.width * 0.85, size.height * 0.05);
    path.lineTo(size.width * 0.95, size.height * 0.05);
    path.lineTo(size.width * 0.85, size.height * 0.2);
    path.close();
    canvas.drawPath(path, fillPaint);

    final path2 = Path();
    path2.moveTo(size.width * 0.1, size.height * 0.9);
    path2.lineTo(size.width * 0.2, size.height * 0.9);
    path2.lineTo(size.width * 0.1, size.height * 0.75);
    path2.close();
    canvas.drawPath(path2, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
