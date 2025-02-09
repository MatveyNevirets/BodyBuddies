// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../core/colors/colors.dart';

class OpenWorkoutsJournal extends StatelessWidget {
  static const Color borderColor = Colours.workout_card_background_color;

  List<ExerciseEntity> emptyList = [];

  OpenWorkoutsJournal({super.key});

  openJournal(BuildContext context) {
    Navigator.of(context).pushNamed("/workouts_menu/workouts_journal/");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => openJournal(context),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              height: MediaQuery.sizeOf(context).height / 5,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 5, color: Colours.workout_card_background_color),
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                  child: Text(
                "Журнал",
                style: Styles.workout_text_style_background_24,
              )),
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
