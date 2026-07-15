// lib/core/widgets/loading_screen.dart
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkTheme.background,
      body: Stack(
        children: [
          // Геометрический фон в стиле концепта
          const Positioned.fill(
            child: _LoadingBackground(),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SpinKitSpinningLines(
                  color: DarkTheme.primary,
                  size: 64,
                  lineWidth: 3,
                ),
                const SizedBox(height: 16),
                Text(
                  Strings.loading.toUpperCase(),
                  style: const TextStyle(
                    color: DarkTheme.secondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Легкий геометрический фон, как на других экранах
class _LoadingBackground extends StatelessWidget {
  const _LoadingBackground();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          top: -60,
          right: -40,
          child: _GeoShape(
            width: 200,
            height: 200,
            rotation: 0.4,
            color: _geoColor,
            shape: _GeoShapeType.triangle,
          ),
        ),
        Positioned(
          top: 120,
          left: -20,
          child: _GeoShape(
            width: 220,
            height: 40,
            rotation: -0.2,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: 80,
          right: -25,
          child: _GeoShape(
            width: 180,
            height: 50,
            rotation: -0.45,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: -40,
          left: -15,
          child: _GeoShape(
            width: 160,
            height: 160,
            rotation: -0.65,
            color: _geoColor,
            shape: _GeoShapeType.triangle,
          ),
        ),
      ],
    );
  }

  static const Color _geoColor = DarkTheme.primary;
}

enum _GeoShapeType { triangle, rectangle }

class _GeoShape extends StatelessWidget {
  final double width;
  final double height;
  final double rotation;
  final Color color;
  final _GeoShapeType shape;

  const _GeoShape({
    required this.width,
    required this.height,
    required this.rotation,
    required this.color,
    required this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Opacity(
        opacity: 0.05,
        child: shape == _GeoShapeType.triangle
            ? CustomPaint(
                size: Size(width, height),
                painter: _TrianglePainter(color),
              )
            : Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
