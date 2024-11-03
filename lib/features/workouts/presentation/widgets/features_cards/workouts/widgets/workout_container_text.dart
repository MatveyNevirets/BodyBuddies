import 'package:flutter/cupertino.dart';

import '../../../../../../../core/colors/colors.dart';
import '../../../../../../../core/styles/styles.dart';

class WorkoutContainerText extends StatelessWidget {
  late String title;
  late double? padding;

  WorkoutContainerText(this.title, this.padding);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: Styles.workouts_containers_text_style,
      ),
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colours.white_text_color),
          borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.all(padding ?? 4),
    );
  }
}
