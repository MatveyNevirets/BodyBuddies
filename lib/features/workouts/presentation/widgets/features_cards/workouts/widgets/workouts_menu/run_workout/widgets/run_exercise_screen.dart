import 'package:flutter/material.dart';

import '../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../core/widgets/base_button.dart';

Container buildRunExerciseScreen() {
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
            buildTimeAndSetsWidget(),
            SizedBox(
              height: 16,
            ),
            buildWorkoutTitleWidget(),
            SizedBox(
              height: 16,
            ),
            buildInputFieldsWidget(),
            SizedBox(
              height: 16,
            ),
            BaseButton(
                onClick: () {},
                buttonText: Strings.done,
                icon: null,
                isElevated: true),
          ],
        ),
      ),
    ),
  );
}

Container buildTimeAndSetsWidget() {
  return Container(
    padding: EdgeInsets.all(16),
    color: Colours.workout_card_foreground_color,
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Время"),
            Text("00:10"),
          ],
        ),
        Expanded(child: SizedBox()),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(Strings.sets),
            Text("data"),
          ],
        ),
      ],
    ),
  );
}

Container buildWorkoutTitleWidget() {
  return Container(
    padding: EdgeInsets.all(16),
    color: Colours.workout_card_foreground_color,
    child: Column(
      children: [
        Text("data"),
      ],
    ),
  );
}

Wrap buildInputFieldsWidget() {
  return Wrap(
    children: [
      Container(
        constraints: BoxConstraints(
          maxWidth: 250,
          maxHeight: 100,
        ),
        color: Colours.workout_card_foreground_color,
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              child: Expanded(
                child: Column(
                  children: [
                    Text("Kg"),
                    TextField(
                      decoration: InputDecoration(hintText: "Kg"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              child: Expanded(
                child: Column(
                  children: [
                    Text("Reps"),
                    TextField(
                      decoration: InputDecoration(hintText: "Reps"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
