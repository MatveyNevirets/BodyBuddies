import 'package:flutter/material.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/widgets/base_button.dart';

class AreYouSureDialog extends StatelessWidget {
  final VoidCallback onSubmit;

  const AreYouSureDialog({
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    // Адаптивные размеры
    final double dialogWidth =
        screenWidth * 0.85 > 400 ? 400 : screenWidth * 0.85;
    final double dialogPadding =
        screenWidth * 0.06 > 32 ? 32 : screenWidth * 0.06;
    final double buttonSpacing =
        screenWidth * 0.04 > 16 ? 16 : screenWidth * 0.04;

    // Цвета (тёмная тема берётся из colorScheme)
    final Color surfaceColor = colorScheme.surface;
    final Color lightSurface =
        Color.lerp(surfaceColor, Colors.white, 0.05) ?? surfaceColor;

    // Стили текста (иерархия H2)
    final titleStyle = theme.textTheme.titleLarge?.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.4,
      color: colorScheme.onSurface,
    );

    final subtitleStyle = theme.textTheme.bodyMedium?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: colorScheme.onSurface.withOpacity(0.55),
    );

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: 1.0,
      child: Center(
        child: Container(
          width: dialogWidth,
          constraints: BoxConstraints(
            maxHeight: screenHeight * 0.7,
            minHeight: 180,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: surfaceColor,
            border: Border.all(
              color: colorScheme.onSurface.withOpacity(0.08),
              width: 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                lightSurface,
                surfaceColor,
              ],
              stops: const [0.0, 0.05],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Геометрический фон (диагональный треугольник, асимметрия)
              Positioned(
                bottom: 0,
                right: 0,
                child: CustomPaint(
                  painter: _DiagonalTrianglePainter(
                    color: colorScheme.primary.withOpacity(0.04),
                  ),
                  size: Size(dialogWidth * 0.5, 120),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(dialogPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Strings.areYouSure,
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Это действие нельзя отменить', // дополнительный текст для «веса»
                      style: subtitleStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: dialogPadding * 0.8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Кнопка "Нет" — вторичная (outlined) с рамкой divider
                        Expanded(
                          flex: 1,
                          child: BaseButton(
                            onClick: () => Navigator.of(context).pop(),
                            buttonText: Strings.no,
                            icon: null,
                            isElevated: false,
                            radius: 14,
                            backgroundColor:
                                colorScheme.outlineVariant, // цвет рамки
                            color: colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: buttonSpacing),
                        // Кнопка "Да" — основная (filled)
                        Expanded(
                          flex: 1,
                          child: BaseButton(
                            onClick: onSubmit,
                            buttonText: Strings.yes,
                            icon: null,
                            isElevated: true,
                            radius: 14,
                            backgroundColor: colorScheme.primary,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ],
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

// Кастомный художник для диагонального треугольника
class _DiagonalTrianglePainter extends CustomPainter {
  final Color color;

  _DiagonalTrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
