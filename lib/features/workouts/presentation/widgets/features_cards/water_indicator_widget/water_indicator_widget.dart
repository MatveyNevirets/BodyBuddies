// ignore_for_file: must_be_immutable

import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/water_indicator_widget/water_entity.dart';
import 'package:flutter/cupertino.dart';

class WaterIndicatorWidget extends StatelessWidget {
  List<WaterEntity> waterCups = List.generate(12, (index) => WaterEntity(index));

  WaterIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(runSpacing: 16, children: waterCups);
  }
}
