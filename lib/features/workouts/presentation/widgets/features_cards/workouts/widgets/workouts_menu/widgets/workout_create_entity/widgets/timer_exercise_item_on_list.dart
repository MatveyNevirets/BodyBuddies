import 'package:flutter/material.dart';

import '../../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../../core/styles/styles.dart';
import '../../workout_entities/entity/exercise_entity.dart';
import '../presentation/workout_create_screen.dart';

Widget buildTimerExerciseItem(Size screenSize, List<ExerciseEntity> exercises,
    int index, List<ExerciseEntity> _exercises) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colours.workout_card_background_color,
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage("lib/assets/images/workout_image.png"),
                  height: screenSize.height / 18,
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colours.workout_card_foreground_color,
                          borderRadius: BorderRadius.circular(4)),
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                      height: screenSize.height / 25,
                      child: Text(
                        textAlign: TextAlign.center,
                        truncateText(exercises[index].title, 13),
                        style: Styles.hint_text_field_fill_workout,
                      )),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenSize.width / 5,
                  height: 30,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colours.workout_card_foreground_color,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextField(
                    onChanged: (value) {
                      exercises[index].timerTimeMinutes = int.parse(value);
                      updateExercise(index, exercises[index], _exercises);
                    },
                    maxLength: 4,
                    buildCounter: null,
                    keyboardType: TextInputType.number,
                    style: Styles.hint_text_field_fill_workout,
                    cursorColor: Colours.workout_card_background_color,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Colours.workout_card_background_color)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Colours.workout_card_background_color)),
                      hintText: Strings.minutes,
                      hintStyle: Styles.hint_text_field_fill_workout,
                      contentPadding: EdgeInsets.only(bottom: 16),
                      counterText: '',
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  width: screenSize.width / 5,
                  height: 30,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colours.workout_card_foreground_color,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextField(
                    onChanged: (value) {
                      exercises[index].timerTimeSeconds = int.parse(value);
                      updateExercise(index, exercises[index], _exercises);
                    },
                    maxLength: 4,
                    buildCounter: null,
                    keyboardType: TextInputType.number,
                    style: Styles.hint_text_field_fill_workout,
                    cursorColor: Colours.workout_card_background_color,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Colours.workout_card_background_color)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Colours.workout_card_background_color)),
                      hintText: Strings.seconds,
                      hintStyle: Styles.hint_text_field_fill_workout,
                      contentPadding: EdgeInsets.only(bottom: 16),
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: 12,
      ),
    ],
  );
}

void updateExercise(
    int index, ExerciseEntity exercise, List<ExerciseEntity> _exercises) {
  _exercises[index] = exercise;
}
