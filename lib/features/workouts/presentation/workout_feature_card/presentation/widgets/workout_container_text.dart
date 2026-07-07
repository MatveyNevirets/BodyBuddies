// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';

import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/themes/themes.dart';

class WorkoutContainerText extends StatelessWidget {
  late String title;
  late double? padding;

  WorkoutContainerText(this.title, this.padding, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colours.white_text_color),
          borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.all(padding ?? 4),
      child: Center(
        child: Text(
          title,
          style: DarkTheme.workouts_containers_text_style,
        ),
      ),
    );
  }
}
