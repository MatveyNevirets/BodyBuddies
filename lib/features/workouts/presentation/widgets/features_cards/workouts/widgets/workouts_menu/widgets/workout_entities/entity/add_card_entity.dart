// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/styles/styles.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../core/colors/colors.dart';

class AddCardEntity extends StatelessWidget {
  static const Color borderColor = Colours.workout_card_background_color;

  BuildContext workoutsMenuContext;

  AddCardEntity(this.workoutsMenuContext, {super.key});

  createWorkout(BuildContext context) {
    Navigator.of(context).pushNamed("/workouts_menu/create_workout/", arguments: workoutsMenuContext);
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
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: borderColor,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: Styles.height_of_text_to_widget,
        ),
      ],
    );
  }
}
