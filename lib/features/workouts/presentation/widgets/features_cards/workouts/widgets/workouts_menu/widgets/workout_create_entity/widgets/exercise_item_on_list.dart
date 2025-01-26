import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../../core/styles/styles.dart';
import '../presentation/workout_create_screen.dart';

buildExerciseItem(Size screenSize, List<ExerciseEntity> exercises, int index,
    List<ExerciseEntity> _exercises) {
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
            buildHeaderCardWidget(screenSize, exercises, index),
            SizedBox(height: 6),
            buildExerciseInputFields(screenSize, exercises, index, _exercises),
            SizedBox(
              height: 12,
            ),
            buildRestOfSetsInputFields(
                screenSize, exercises, index, _exercises),
            SizedBox(
              height: 8,
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

Column buildRestOfSetsInputFields(
    Size screenSize,
    List<ExerciseEntity> exercises,
    int index,
    List<ExerciseEntity> _exercises) {
  return Column(
    children: [
      Text(
        Strings.rest_of_sets,
        style: Styles.workout_exercise_card_style,
      ),
      SizedBox(
        height: 6,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenSize.width / 4,
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
          Expanded(
            child: SizedBox(),
          ),
          Container(
            width: screenSize.width / 4,
            height: 30,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colours.workout_card_foreground_color,
                borderRadius: BorderRadius.circular(4)),
            child: TextField(
              onChanged: (value) {
                exercises[index].restTimeInSeconds = int.parse(value);
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
  );
}

Row buildExerciseInputFields(Size screenSize, List<ExerciseEntity> exercises,
    int index, List<ExerciseEntity> _exercises) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: screenSize.width / 7,
        height: 30,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colours.workout_card_foreground_color,
            borderRadius: BorderRadius.circular(4)),
        child: TextField(
          onChanged: (value) {
            exercises[index].kilograms = int.parse(value);
            updateExercise(index, exercises[index], _exercises);
          },
          keyboardType: TextInputType.number,
          maxLength: 4,
          buildCounter: null,
          style: Styles.hint_text_field_fill_workout,
          cursorColor: Colours.workout_card_background_color,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Colours.workout_card_background_color)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Colours.workout_card_background_color)),
            hintText: Strings.weight,
            hintStyle: Styles.hint_text_field_fill_workout,
            contentPadding: EdgeInsets.only(bottom: 16),
            counterText: '',
          ),
        ),
      ),
      Expanded(child: SizedBox()),
      Container(
        width: screenSize.width / 7,
        height: 30,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colours.workout_card_foreground_color,
            borderRadius: BorderRadius.circular(4)),
        child: TextField(
          onChanged: (value) {
            exercises[index].sets = int.parse(value);
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
                    width: 2, color: Colours.workout_card_background_color)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Colours.workout_card_background_color)),
            hintText: Strings.sets,
            hintStyle: Styles.hint_text_field_fill_workout,
            contentPadding: EdgeInsets.only(bottom: 16),
            counterText: '',
          ),
        ),
      ),
      Expanded(child: SizedBox()),
      Container(
        width: screenSize.width / 7,
        height: 30,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colours.workout_card_foreground_color,
            borderRadius: BorderRadius.circular(4)),
        child: TextField(
          onChanged: (value) {
            exercises[index].reps = int.parse(value);
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
                    width: 2, color: Colours.workout_card_background_color)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Colours.workout_card_background_color)),
            hintText: Strings.reps,
            hintStyle: Styles.hint_text_field_fill_workout,
            contentPadding: EdgeInsets.only(bottom: 16),
            counterText: '',
          ),
        ),
      ),
      SizedBox(width: 8),
    ],
  );
}

Row buildHeaderCardWidget(
    Size screenSize, List<ExerciseEntity> exercises, int index) {
  return Row(
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
  );
}

void updateExercise(
    int index, ExerciseEntity exercise, List<ExerciseEntity> _exercises) {
  _exercises[index] = exercise;
}
