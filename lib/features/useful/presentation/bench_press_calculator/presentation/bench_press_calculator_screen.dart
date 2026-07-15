// lib/features/useful/presentation/bench_press_calculator/presentation/bench_press_calculator_screen.dart
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/useful/presentation/bench_press_calculator/presentation/bloc/bench_press_calculator_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BenchPressCalculatorScreen extends StatelessWidget {
  BenchPressCalculatorScreen({super.key});

  final weightController = TextEditingController();
  final repsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: DarkTheme.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Калькулятор жима',
          style: DarkTheme.appbar_text_style,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Геометрический фон
          const Positioned.fill(
            child: _GeometricBackground(),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              child: Column(
                children: [
                  _buildInputCard(context),
                  const SizedBox(height: 24),
                  _buildResultsCard(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: DarkTheme.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(
            icon: Icons.fitness_center_rounded,
            title: Strings.weight,
            controller: weightController,
          ),
          const SizedBox(height: 20),
          _buildInputField(
            icon: Icons.repeat_rounded,
            title: Strings.reps,
            controller: repsController,
          ),
          const SizedBox(height: 24),
          BaseButton(
            onClick: () => _calculateResults(context),
            buttonText: Strings.calculate,
            icon: null,
            isElevated: true,
            backgroundColor: DarkTheme.primary,
            color: DarkTheme.background,
            buttonSize: const Size(double.maxFinite, 50),
            radius: 14,
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String title,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: DarkTheme.secondary),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: DarkTheme.secondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: DarkTheme.backgroundSecondary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: DarkTheme.divider, width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: TextField(
            style: DarkTheme.body_text_style,
            cursorColor: DarkTheme.primary,
            keyboardType: TextInputType.number,
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: DarkTheme.divider, width: 1),
      ),
      child: BlocBuilder<BenchPressCalculatorBloc, BenchPressCalculatorState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Результаты',
                style: DarkTheme.title_text_style.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 16),
              const Divider(color: DarkTheme.divider, height: 1),
              const SizedBox(height: 16),
              Text(
                'Приблизительно ваш максимальный жим',
                style: DarkTheme.body_text_style.copyWith(
                  color: DarkTheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              _buildAverageResult(state.averageResult.toString()),
              const SizedBox(height: 24),
              const Divider(color: DarkTheme.divider, height: 1),
              const SizedBox(height: 20),
              _buildFormulaRow(
                  'Формула Эпли', state.epleysFormulaResult.toString()),
              _buildFormulaRow('Формула Мэтта Бжицки',
                  state.mattBrzyckisFormulaResult.toString()),
              _buildFormulaRow(
                  'Формула Лэндера', state.landersFormulaResult.toString()),
              _buildFormulaRow(
                  'Формула О\'Коннор', state.oConnersFormulaResult.toString()),
            ],
          );
        },
        buildWhen: (prev, curr) =>
            !const ListEquality().equals(prev.props, curr.props),
      ),
    );
  }

  Widget _buildFormulaRow(String name, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: const TextStyle(
                color: DarkTheme.secondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: DarkTheme.backgroundSecondary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: DarkTheme.divider, width: 1),
              ),
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: DarkTheme.body_text_style.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAverageResult(String value) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: DarkTheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border:
            Border.all(color: DarkTheme.primary.withOpacity(0.25), width: 1),
      ),
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: DarkTheme.title_text_style.copyWith(fontSize: 32),
      ),
    );
  }

  void _calculateResults(BuildContext context) {
    context.read<BenchPressCalculatorBloc>().add(
          CalculateEvent(
            double.parse(weightController.text),
            int.parse(repsController.text),
          ),
        );
  }
}

// --- Геометрический фон (аналогично HomeScreen) ---
class _GeometricBackground extends StatelessWidget {
  const _GeometricBackground();

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
            rotation: 0.35,
            color: _geoColor,
            shape: _GeoShapeType.triangle,
          ),
        ),
        Positioned(
          top: 160,
          left: -30,
          child: _GeoShape(
            width: 240,
            height: 40,
            rotation: -0.2,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: 80,
          right: -30,
          child: _GeoShape(
            width: 190,
            height: 60,
            rotation: -0.4,
            color: _geoColor,
            shape: _GeoShapeType.rectangle,
          ),
        ),
        Positioned(
          bottom: -50,
          left: -20,
          child: _GeoShape(
            width: 180,
            height: 180,
            rotation: -0.55,
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
