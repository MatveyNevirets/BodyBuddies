// lib/features/water_indicator_widget/presentation/water_indicator_widget.dart
import 'package:body_buddies/features/water_indicator_widget/water_entity.dart';
import 'package:flutter/cupertino.dart';

class WaterIndicatorWidget extends StatelessWidget {
  final List<WaterEntity> waterCups =
      List.generate(12, (index) => WaterEntity(index));

  WaterIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0E1D2D),
            Color(0xFF12263A),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFF244055),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xAA04101A),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 12,
        children: waterCups,
      ),
    );
  }
}
