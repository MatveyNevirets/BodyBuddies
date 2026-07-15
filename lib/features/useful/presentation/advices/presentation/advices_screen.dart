import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/useful/presentation/advices/presentation/bloc/advices_bloc.dart';
import 'package:body_buddies/features/useful/presentation/advices/widgets/advice_card.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvicesScreen extends StatelessWidget {
  const AdvicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkTheme.background,
      body: Stack(
        children: [
          // Геометрия фона — напряжение и движение
          Positioned.fill(
            child: CustomPaint(
              painter: _AdvicesBackgroundPainter(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<AdvicesBloc, AdvicesState>(
                builder: (context, state) {
                  if (state is FetchAdvices) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 16, bottom: 24),
                      itemCount: state.advices.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: buildAdviceCard(context, index, state.advices),
                        );
                      },
                    );
                  }
                  return const LoadingScreen();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Фоновая геометрия для экрана советов
// ============================================================================
class _AdvicesBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = DarkTheme.primary.withOpacity(0.05)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = DarkTheme.secondary.withOpacity(0.04)
      ..style = PaintingStyle.fill;

    // Диагональные линии — векторы усилия
    canvas.drawLine(
      Offset(0, size.height * 0.2),
      Offset(size.width * 0.35, size.height * 0.45),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width * 0.85, size.height * 0.18),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.9),
      Offset(size.width * 0.6, size.height),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.88, size.height * 0.75),
      Offset(size.width, size.height * 0.92),
      linePaint,
    );

    // Вытянутые прямоугольники — массивные плиты
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.08,
        size.height * 0.12,
        size.width * 0.12,
        size.height * 0.06,
      ),
      fillPaint..color = DarkTheme.primary.withOpacity(0.05),
    );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.82,
        size.height * 0.68,
        size.width * 0.13,
        size.height * 0.07,
      ),
      fillPaint..color = DarkTheme.secondary.withOpacity(0.04),
    );

    // Треугольники — напряжённая геометрия
    final triangle1 = Path()
      ..moveTo(size.width * 0.9, size.height * 0.04)
      ..lineTo(size.width, size.height * 0.04)
      ..lineTo(size.width, size.height * 0.14)
      ..close();
    canvas.drawPath(
      triangle1,
      fillPaint..color = DarkTheme.primary.withOpacity(0.06),
    );

    final triangle2 = Path()
      ..moveTo(size.width * 0.05, size.height * 0.9)
      ..lineTo(size.width * 0.13, size.height * 0.9)
      ..lineTo(size.width * 0.05, size.height * 0.78)
      ..close();
    canvas.drawPath(
      triangle2,
      fillPaint..color = DarkTheme.secondary.withOpacity(0.05),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
