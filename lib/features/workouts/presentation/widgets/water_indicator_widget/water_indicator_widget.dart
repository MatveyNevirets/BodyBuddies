import 'package:body_buddies/features/workouts/presentation/widgets/water_indicator_widget/water_entity.dart';
import 'package:flutter/cupertino.dart';

class WaterIndicatorWidget extends StatelessWidget {

  List<WaterEntity> waterCups = [
    WaterEntity(0),
    WaterEntity(1),
    WaterEntity(2),
    WaterEntity(3),
    WaterEntity(4),
    WaterEntity(5),
    WaterEntity(6),
    WaterEntity(7),
    WaterEntity(8),
    WaterEntity(9),
    WaterEntity(10),
    WaterEntity(11),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: waterCups
    );
  }
}
