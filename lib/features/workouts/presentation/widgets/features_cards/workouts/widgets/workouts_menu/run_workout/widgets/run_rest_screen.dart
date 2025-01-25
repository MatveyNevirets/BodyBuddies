import 'package:flutter/material.dart';

import '../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../core/widgets/base_button.dart';

Container buildRestScreen() {
  return Container(
    margin: EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 64),
    child: Card(
      color: Colours.workout_card_background_color,
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(16),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            buildWorkoutTimeWidget(),
            SizedBox(
              height: 16,
            ),
            buildRestTextWidget(),
            SizedBox(
              height: 16,
            ),
            BaseButton(
                onClick: () {},
                buttonText: Strings.skip,
                icon: null,
                isElevated: true),
          ],
        ),
      ),
    ),
  );
}

Container buildWorkoutTimeWidget() {
  return Container(
    padding: EdgeInsets.all(16),
    color: Colours.workout_card_foreground_color,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Время"),
        Text("00:10"),
      ],
    ),
  );
}

Container buildRestTextWidget() {
  return Container(
    padding: EdgeInsets.all(16),
    color: Colours.workout_card_foreground_color,
    child: Column(
      children: [
        Text("Отдых"),
        Text("60"),
      ],
    ),
  );
}

