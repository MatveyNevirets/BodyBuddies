import 'package:body_buddies/features/workouts/presentation/bloc/water_cups_bloc/water_cups_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/water_indicator_widget/water_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WaterIndicatorWidget extends StatelessWidget {
  List<WaterEntity> waterCups = List.generate(12, (index) => WaterEntity(index));

  @override
  Widget build(BuildContext context) {
    return Wrap(runSpacing: 16, children: waterCups);
  }
}
