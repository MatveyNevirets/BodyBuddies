import 'package:body_buddies/core/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../core/colors/colors.dart';

class AddCardEntity extends StatelessWidget {
  static final Color borderColor = Colours.workout_card_background_color;

  createWorkout(BuildContext context) {
    Navigator.of(context).pushNamed("/workouts_menu/create_workout/");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => createWorkout(context),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              height: MediaQuery.sizeOf(context).height / 5,
              decoration: BoxDecoration(
                  border: Border.all(width: 4, color: borderColor),
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: borderColor,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: Styles.height_of_text_to_widget,
        ),
      ],
    );
  }
}
