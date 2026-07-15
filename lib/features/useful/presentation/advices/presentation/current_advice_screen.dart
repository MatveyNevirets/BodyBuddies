import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/useful/domain/entity/advice_entity.dart';
import 'package:flutter/material.dart';

class CurrentAdviceScreen extends StatelessWidget {
  const CurrentAdviceScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentAdvice =
        ModalRoute.of(context)!.settings.arguments as AdviceEntity;

    return Scaffold(
      backgroundColor: DarkTheme.background,
      body: Stack(
        children: [
          // Фоновая геометрия
          Positioned.fill(
            child: CustomPaint(
              painter: _CurrentAdviceBackgroundPainter(),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(24),
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
                          Color(0xFF1F2533), // lighten surface на 3-4%
                          DarkTheme.surface,
                        ],
                        stops: [0.0, 0.05],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentAdvice.title,
                          style: DarkTheme.title_text_style,
                        ),
                        const SizedBox(height: 16),
                        // Жесткая металлическая черта вместо тонкого контейнера
                        Container(
                          height: 2,
                          width: 64,
                          decoration: BoxDecoration(
                            color: DarkTheme.primary,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          currentAdvice.bodyText,
                          style: DarkTheme.body_text_style.copyWith(
                            height: 1.5,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Фоновый художник для экрана просмотра совета
// ============================================================================
class _CurrentAdviceBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = DarkTheme.primary.withOpacity(0.05)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = DarkTheme.secondary.withOpacity(0.04)
      ..style = PaintingStyle.fill;

    // Диагональные направляющие
    canvas.drawLine(
      Offset(0, size.height * 0.18),
      Offset(size.width * 0.4, size.height * 0.5),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.75, 0),
      Offset(size.width * 0.9, size.height * 0.22),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.25, size.height * 0.85),
      Offset(size.width * 0.65, size.height),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.88, size.height * 0.7),
      Offset(size.width, size.height * 0.88),
      linePaint,
    );

    // Вытянутые прямоугольники — массивные плиты
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.07,
        size.height * 0.1,
        size.width * 0.14,
        size.height * 0.07,
      ),
      fillPaint..color = DarkTheme.primary.withOpacity(0.05),
    );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.8,
        size.height * 0.65,
        size.width * 0.15,
        size.height * 0.08,
      ),
      fillPaint..color = DarkTheme.secondary.withOpacity(0.04),
    );

    // Треугольники — напряжение
    final triangle1 = Path()
      ..moveTo(size.width * 0.92, size.height * 0.05)
      ..lineTo(size.width, size.height * 0.05)
      ..lineTo(size.width, size.height * 0.16)
      ..close();
    canvas.drawPath(
      triangle1,
      fillPaint..color = DarkTheme.primary.withOpacity(0.06),
    );

    final triangle2 = Path()
      ..moveTo(size.width * 0.04, size.height * 0.88)
      ..lineTo(size.width * 0.12, size.height * 0.88)
      ..lineTo(size.width * 0.04, size.height * 0.76)
      ..close();
    canvas.drawPath(
      triangle2,
      fillPaint..color = DarkTheme.secondary.withOpacity(0.05),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
