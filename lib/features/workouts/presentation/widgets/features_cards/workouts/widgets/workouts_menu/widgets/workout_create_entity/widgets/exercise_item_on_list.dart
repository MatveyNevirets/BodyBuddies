import 'package:flutter/material.dart';

import '../../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../../core/styles/styles.dart';
import '../../workout_entities/entity/exercise_entity.dart';
import '../presentation/workout_create_screen.dart';

class ExerciseItemOnList extends StatelessWidget {
  final BuildContext context;
  final Size screenSize;
  final int index;
  final List<ExerciseEntity> exercises;

  final VoidCallback onRemoveItem;

  bool isEdited = false;

  ExerciseItemOnList(
      this.context, this.screenSize, this.index, this.exercises, this.isEdited,
      {super.key, required this.onRemoveItem});

  @override
  Widget build(BuildContext context) {
    String? weightText;
    String? repsText;
    String? setsText;
    String? restTimeOfSecondsText;
    String? restTimeOfMinutesText;

    if (isEdited) {
      var weight = exercises[index].kilograms;
      var reps = exercises[index].reps;
      var sets = exercises[index].sets;
      var restTimeOfSeconds = exercises[index].restTimeInSeconds;
      var resTimeOfMinutes = exercises[index].restTimeInMinutes;

      weight == weight.toInt()
          ? weightText = weight.toInt().toString()
          : weightText = weight.toString();

      reps == reps.toInt()
          ? repsText = reps.toInt().toString()
          : repsText = reps.toString();

      sets == sets.toInt()
          ? setsText = sets.toInt().toString()
          : setsText = sets.toString();

      resTimeOfMinutes == resTimeOfMinutes.toInt()
          ? restTimeOfMinutesText = resTimeOfMinutes.toInt().toString()
          : restTimeOfMinutesText = resTimeOfMinutes.toString();

      restTimeOfSeconds == restTimeOfSeconds.toInt()
          ? restTimeOfSecondsText = restTimeOfSeconds.toInt().toString()
          : restTimeOfSecondsText = restTimeOfSeconds.toString();
    }

    TextEditingController weightController =
        TextEditingController(text: isEdited ? weightText : "");
    TextEditingController setsContorller =
        TextEditingController(text: isEdited ? setsText : "");
    TextEditingController repsController =
        TextEditingController(text: isEdited ? repsText : "");
    TextEditingController restTimeOfMinutesController =
        TextEditingController(text: isEdited ? restTimeOfMinutesText : "");
    TextEditingController restTimOfSecondsController =
        TextEditingController(text: isEdited ? restTimeOfSecondsText : "");

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colours.workout_card_background_color,
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildHeaderCardWidget(screenSize, exercises, index),
              buildExerciseTitle(screenSize, exercises, index),
              const SizedBox(height: 6),
              buildExerciseInputFields(context, screenSize, exercises, index,
                  weightController, setsContorller, repsController),
              const SizedBox(
                height: 12,
              ),
              buildRestOfSetsInputFields(context, screenSize, exercises, index,
                  restTimeOfMinutesController, restTimOfSecondsController),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Container buildExerciseTitle(
      Size screenSize, List<ExerciseEntity> exercises, int index) {
    return Container(
        decoration: BoxDecoration(
            color: Colours.workoutCardForegroundColor,
            borderRadius: BorderRadius.circular(4)),
        margin: const EdgeInsets.all(8),
        height: screenSize.height / 25,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Text(
          textAlign: TextAlign.center,
          truncateText(exercises[index].title, 15),
          style: Styles.hint_text_field_fill_workout,
        ));
  }

  Column buildRestOfSetsInputFields(
      BuildContext context,
      Size screenSize,
      List<ExerciseEntity> exercises,
      int index,
      TextEditingController restMinutesController,
      restSecondsController) {
    return Column(
      children: [
        Text(
          Strings.rest_of_sets,
          style: Styles.workout_exercise_card_style,
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenSize.width / 4,
              height: 30,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colours.workoutCardForegroundColor,
                  borderRadius: BorderRadius.circular(4)),
              child: TextField(
                controller: restMinutesController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    exercises[index].restTimeInMinutes =
                        int.parse(restMinutesController.text);
                  } else {
                    exercises[index].restTimeInMinutes = 0;
                  }
                },
                maxLength: 4,
                buildCounter: null,
                keyboardType: TextInputType.number,
                style: Styles.hint_text_field_fill_workout,
                cursorColor: Colours.workout_card_background_color,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          color: Colours.workout_card_background_color)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          color: Colours.workout_card_background_color)),
                  hintText: Strings.minutes,
                  hintStyle: Styles.hint_text_field_fill_workout,
                  contentPadding: const EdgeInsets.only(bottom: 16),
                  counterText: '',
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Container(
              width: screenSize.width / 4,
              height: 30,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colours.workoutCardForegroundColor,
                  borderRadius: BorderRadius.circular(4)),
              child: TextField(
                controller: restSecondsController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    exercises[index].restTimeInSeconds =
                        int.parse(restSecondsController.text);
                  } else {
                    exercises[index].restTimeInSeconds = 0;
                  }
                },
                maxLength: 4,
                buildCounter: null,
                keyboardType: TextInputType.number,
                style: Styles.hint_text_field_fill_workout,
                cursorColor: Colours.workout_card_background_color,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          color: Colours.workout_card_background_color)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          color: Colours.workout_card_background_color)),
                  hintText: Strings.seconds,
                  hintStyle: Styles.hint_text_field_fill_workout,
                  contentPadding: const EdgeInsets.only(bottom: 16),
                  counterText: '',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row buildExerciseInputFields(
      BuildContext context,
      Size screenSize,
      List<ExerciseEntity> exercises,
      int index,
      TextEditingController weightController,
      setsController,
      repsController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: screenSize.width / 7,
          height: 30,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colours.workoutCardForegroundColor,
              borderRadius: BorderRadius.circular(4)),
          child: TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            maxLength: 4,
            onChanged: (value) {
              if (value.isNotEmpty) {
                exercises[index].kilograms =
                    double.parse(weightController.text);
              } else {
                exercises[index].kilograms = 0;
              }
            },
            buildCounter: null,
            style: Styles.hint_text_field_fill_workout,
            cursorColor: Colours.workout_card_background_color,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Colours.workout_card_background_color)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Colours.workout_card_background_color)),
              hintText: Strings.weight,
              hintStyle: Styles.hint_text_field_fill_workout,
              contentPadding: const EdgeInsets.only(bottom: 16),
              counterText: '',
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        Container(
          width: screenSize.width / 7,
          height: 30,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colours.workoutCardForegroundColor,
              borderRadius: BorderRadius.circular(4)),
          child: TextField(
            controller: setsController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                exercises[index].sets = int.parse(setsController.text);
              } else {
                exercises[index].sets = 0;
              }
            },
            maxLength: 4,
            buildCounter: null,
            keyboardType: TextInputType.number,
            style: Styles.hint_text_field_fill_workout,
            cursorColor: Colours.workout_card_background_color,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Colours.workout_card_background_color)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Colours.workout_card_background_color)),
              hintText: Strings.sets,
              hintStyle: Styles.hint_text_field_fill_workout,
              contentPadding: const EdgeInsets.only(bottom: 16),
              counterText: '',
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        Container(
          width: screenSize.width / 7,
          height: 30,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colours.workoutCardForegroundColor,
              borderRadius: BorderRadius.circular(4)),
          child: TextField(
            controller: repsController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                exercises[index].reps = int.parse(repsController.text);
              } else {
                exercises[index].reps = 0;
              }
            },
            maxLength: 4,
            buildCounter: null,
            keyboardType: TextInputType.number,
            style: Styles.hint_text_field_fill_workout,
            cursorColor: Colours.workout_card_background_color,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Colours.workout_card_background_color)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Colours.workout_card_background_color)),
              hintText: Strings.reps,
              hintStyle: Styles.hint_text_field_fill_workout,
              contentPadding: const EdgeInsets.only(bottom: 16),
              counterText: '',
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Row buildHeaderCardWidget(
      Size screenSize, List<ExerciseEntity> exercises, int index) {
    return Row(
      children: [
        Image(
          image: const AssetImage("lib/assets/images/workout_image.png"),
          height: screenSize.height / 18,
        ),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                  color: Colours.workoutCardForegroundColor,
                  borderRadius: BorderRadius.circular(4)),
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              height: screenSize.height / 25,
              child: Text(
                textAlign: TextAlign.center,
                "        ",
                style: Styles.hint_text_field_fill_workout,
              )),
        ),
        GestureDetector(
          onTap: () => removeExercise(),
          child: Icon(
            Icons.delete,
            size: 25,
            color: Colours.workoutCardForegroundColor,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }

  void removeExercise() {
    onRemoveItem.call();
  }
}
