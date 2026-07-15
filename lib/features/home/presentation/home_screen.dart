// lib/features/home/presentation/home_screen.dart
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/material.dart';

import '../../useful/useful_feature_card/presentation/useful_feature_card.dart';
import '../../water_indicator/water_indicator.dart';
import '../../workouts/presentation/workout_feature_card/presentation/workouts_feature_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.workoutsRepository,
    required this.secureStorage,
    required this.isConnection,
  });

  final WorkoutsRepository workoutsRepository;
  final SecureStorage secureStorage;
  final bool isConnection;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final greeting = _greeting(now.hour);

    return Scaffold(
      backgroundColor: DarkTheme.background,
      body: Stack(
        children: [
          // Геометрический фон (асимметричные фигуры)
          const Positioned.fill(
            child: _GeometricBackground(),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                children: [
                  _buildHeader(greeting),
                  const SizedBox(height: 28),
                  const _SectionHeader(
                    title: 'Тренировки',
                    subtitle: 'Быстрый доступ к плану',
                    icon: Icons.fitness_center_rounded,
                  ),
                  const SizedBox(height: 14),
                  WorkoutFeatureCard(
                    workoutsRepository: widget.workoutsRepository,
                    secureStorage: widget.secureStorage,
                  ),
                  const SizedBox(height: 28),
                  const _SectionHeader(
                    title: 'Вода',
                    subtitle: 'Контроль привычки каждый день',
                    icon: Icons.water_drop_rounded,
                  ),
                  const SizedBox(height: 14),
                  _SurfaceContainer(
                    child: Center(
                      child: WaterIndicator(),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const _SectionHeader(
                    title: 'Полезное',
                    subtitle: 'Инструменты для прогресса',
                    icon: Icons.auto_awesome_rounded,
                  ),
                  const SizedBox(height: 14),
                  UsefulFeatureCard(
                    isConnection: widget.isConnection,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String greeting) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: const TextStyle(
                    color: DarkTheme.secondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Body Buddies',
                  style: DarkTheme.title_text_style,
                ),
              ],
            ),
          ),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: DarkTheme.divider,
                width: 1.5,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  DarkTheme.primary.withOpacity(0.18),
                  DarkTheme.secondary.withOpacity(0.12),
                ],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.person_rounded,
                color: DarkTheme.primary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _greeting(int hour) {
    if (hour >= 5 && hour < 12) return 'Доброе утро';
    if (hour >= 12 && hour < 17) return 'Добрый день';
    if (hour >= 17 && hour < 21) return 'Добрый вечер';
    return 'Доброй ночи';
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: DarkTheme.surface,
            border: Border.all(color: DarkTheme.divider, width: 1),
          ),
          child: Icon(
            icon,
            size: 17,
            color: DarkTheme.secondary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: DarkTheme.primary,
                  fontSize: 18,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  color: DarkTheme.secondary,
                  fontSize: 13,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SurfaceContainer extends StatelessWidget {
  final Widget child;

  const _SurfaceContainer({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarkTheme.surface.withAlpha(100),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: DarkTheme.divider,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}

class _GeometricBackground extends StatelessWidget {
  const _GeometricBackground();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        // Треугольник в правом верхнем углу
        Positioned(
          top: -60,
          right: -30,
          child: _GeoShape(
            width: 220,
            height: 220,
            rotation: 0.4,
            color: _geoColor,
            shape: _GeoShapeType.triangle,
          ),
        ),
        // Диагональная полоса слева
        Positioned(
          top: 120,
          left: -40,
          child: _GeoShape(
            width: 280,
            height: 48,
            rotation: -0.15,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        // Вытянутый прямоугольник внизу справа
        Positioned(
          bottom: 40,
          right: -20,
          child: _GeoShape(
            width: 180,
            height: 70,
            rotation: -0.35,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        // Второй треугольник внизу слева
        Positioned(
          bottom: -40,
          left: -20,
          child: _GeoShape(
            width: 200,
            height: 200,
            rotation: -0.6,
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
