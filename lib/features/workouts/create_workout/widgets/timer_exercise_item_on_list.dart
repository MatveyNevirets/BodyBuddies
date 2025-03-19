import 'package:body_buddies/features/workouts/workouts_menu/domain/entity/exercise_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/strings/strings.dart';
import '../../../../core/styles/styles.dart';
import '../presentation/workout_create_screen.dart';

class TimerExerciseItemOnList extends StatefulWidget {
  final BuildContext context;
  final Size screenSize;
  final int index;
  final List<ExerciseEntity> exercises;

  final VoidCallback onRemoveItem;

  TimerExerciseItemOnList(
      this.context, this.screenSize, this.index, this.exercises, this.isEdited,
      {super.key, required this.onRemoveItem});

  bool isEdited = false;

  @override
  State<TimerExerciseItemOnList> createState() =>
      _TimerExerciseItemOnListState();
}

class _TimerExerciseItemOnListState extends State<TimerExerciseItemOnList> {
  late TextEditingController exerciseMinutesController;
  late TextEditingController exerciseSecondsController;
  late TextEditingController setsController;
  late TextEditingController weightController;
  late TextEditingController restMinutesController;
  late TextEditingController restSecondsController;

  @override
  void initState() {
    super.initState();
    exerciseMinutesController = TextEditingController();
    exerciseSecondsController = TextEditingController();
    weightController = TextEditingController();
    setsController = TextEditingController();
    restMinutesController = TextEditingController();
    restSecondsController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    String? weightText;
    String? setsText;
    String? restSecondsText;
    String? restMinutesText;
    String? exerciseSecondsText;
    String? exerciseMinutesText;

    if (widget.isEdited) {
      var weight = widget.exercises[widget.index].kilograms;
      var sets = widget.exercises[widget.index].sets;
      var restTimeOfSeconds = widget.exercises[widget.index].restTimeInSeconds;
      var restTimeOfMinutes = widget.exercises[widget.index].restTimeInMinutes;
      var exerciseTimeMinutes = widget.exercises[widget.index].timerTimeMinutes;
      var exericseTimeSeconds = widget.exercises[widget.index].timerTimeSeconds;

      weight == weight.toInt()
          ? weightText = weight.toInt().toString()
          : weightText = weight.toString();

      sets == sets.toInt()
          ? setsText = sets.toInt().toString()
          : setsText = sets.toString();

      restMinutesText = restTimeOfMinutes.toString();
      restSecondsText = restTimeOfSeconds.toString();

      exerciseMinutesText = exerciseTimeMinutes.toString();
      exerciseSecondsText = exericseTimeSeconds.toString();

      weightController.text = widget.isEdited ? weightText.toString() : "";
      setsController.text = widget.isEdited ? setsText.toString() : "";
      restMinutesController.text =
          widget.isEdited ? restMinutesText.toString() : "";
      restSecondsController.text =
          widget.isEdited ? restSecondsText.toString() : "";
      exerciseMinutesController.text =
          widget.isEdited ? exerciseMinutesText.toString() : "";
      exerciseSecondsController.text =
          widget.isEdited ? exerciseSecondsText.toString() : "";
    }

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
              buildHeaderCardWidget(
                  widget.screenSize, widget.exercises, widget.index),
              buildExerciseTitle(
                  widget.screenSize, widget.exercises, widget.index),
              const SizedBox(height: 6),
              buildTimerExerciseInputFields(
                  context, widget.screenSize, widget.exercises, widget.index),
              const SizedBox(
                height: 12,
              ),
              buildExerciseParameters(
                  context, widget.screenSize, widget.exercises, widget.index),
              const SizedBox(
                height: 12,
              ),
              buildRestOfSetsInputFields(
                  context, widget.screenSize, widget.exercises, widget.index),
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
  ) {
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

  Column buildExerciseParameters(BuildContext context, Size screenSize,
      List<ExerciseEntity> exercises, int index) {
    return Column(
      children: [
        Text(
          Strings.add_timer_exercise_parameters,
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
                          width: 2,
                          color: Colours.workout_card_background_color)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          color: Colours.workout_card_background_color)),
                  hintText: Strings.sets,
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
                controller: weightController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    exercises[index].kilograms =
                        double.parse(weightController.text);
                  } else {
                    exercises[index].kilograms = 0;
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
                  hintText: Strings.weight,
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

  Column buildTimerExerciseInputFields(BuildContext context, Size screenSize,
      List<ExerciseEntity> exercises, int index) {
    return Column(
      children: [
        Text(
          Strings.time_of_timer_exercise,
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
                controller: exerciseMinutesController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    exercises[index].timerTimeMinutes =
                        int.parse(exerciseMinutesController.text);
                  } else {
                    exercises[index].timerTimeMinutes = 0;
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
                controller: exerciseSecondsController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    exercises[index].timerTimeSeconds =
                        int.parse(exerciseSecondsController.text);
                  } else {
                    exercises[index].timerTimeSeconds = 0;
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
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                (index + 1).toString(),
                style: Styles.hint_text_style_create_workout,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => removeExercise(),
          child: const Icon(
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
    widget.onRemoveItem.call();
  }
}
