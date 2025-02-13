// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/strings/strings.dart';
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
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              height: MediaQuery.sizeOf(context).height / 5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: const [70, 100],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: Colours.journalGradientColors),
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Image(
                      image: const AssetImage(
                          "lib/assets/images/journal_image.png"),
                      height: MediaQuery.sizeOf(context).height / 8,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.journal,
                            style: Styles.journal_foreground_text_style,
                          ),
                          Text(
                            Strings.workouts,
                            style: Styles.journal_foreground_text_style,
                          ),
                        ],
                      ),
                    ),
                  ],
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
