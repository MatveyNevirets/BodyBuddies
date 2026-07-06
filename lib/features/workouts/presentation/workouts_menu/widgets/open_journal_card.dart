// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/colors/colors.dart';

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
                  gradient: LinearGradient(
                      stops: const [0, 100],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: Colours.journalGradientColors),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).focusColor,
                        blurRadius: 3,
                        spreadRadius: 1)
                  ],
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Image(
                      image:
                          const AssetImage("assets/images/journal_image.png"),
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
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                    blurRadius: 4,
                                    color: Theme.of(context).focusColor,
                                    offset: const Offset(0, 1))
                              ],
                              fontFamily: 'AqumTwo',
                              fontSize: 24,
                              color: Theme.of(context).focusColor,
                            ),
                          ),
                          Text(
                            Strings.workouts,
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                    blurRadius: 4,
                                    color: Theme.of(context).focusColor,
                                    offset: const Offset(0, 1))
                              ],
                              fontFamily: 'AqumTwo',
                              fontSize: 24,
                              color: Theme.of(context).focusColor,
                            ),
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
          height: DarkTheme.height_of_text_to_widget,
        ),
      ],
    );
  }
}
