import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../../../../../../core/styles/styles.dart';
import '../../../../../../../../../../../../../../home/presentation/widgets/body_home_data.dart';
import '../../../../../../../domain/exercises_database.dart';

class AddYourExerciseScreen extends StatefulWidget {
  final BodyHomeData mainFrontendData;
  final Exercises exercises;

  AddYourExerciseScreen(
      {super.key, required this.mainFrontendData, required this.exercises});

  @override
  State<AddYourExerciseScreen> createState() => _AddYourExerciseScreenState();
}

class _AddYourExerciseScreenState extends State<AddYourExerciseScreen> {
  final titleController = TextEditingController();
  final minutesController = TextEditingController();
  final secondsController = TextEditingController();

  bool isTimerExercise = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.mainFrontendData
          .createAppBarWidget(appbarTitle: Strings.creating_appbar),
      body: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 64),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colours.workout_card_background_color),
            child: Card(
              elevation: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colours.workout_card_foreground_color),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Введите название своего упражнения",
                      style: Styles.workout_text_style_background_24,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colours.workout_card_background_color,
                          borderRadius: BorderRadius.circular(8)),
                      child: TextField(
                        buildCounter: null,
                        controller: titleController,
                        cursorColor: Colours.workout_card_foreground_color,
                        textAlign: TextAlign.start,
                        style: Styles.hint_text_style_create_exercise,
                        decoration: InputDecoration(
                          isDense: true,
                          hintStyle: Styles.hint_text_style_create_exercise,
                          hintText: Strings.title,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colours.workout_card_foreground_color,
                                width: 3),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colours.workout_card_foreground_color,
                                width: 3),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Text(
                          "По таймеру",
                          style: Styles.workout_text_style_background_24,
                        ),
                        Expanded(child: SizedBox()),
                        Checkbox(
                          checkColor: Colours.workout_card_foreground_color,
                          activeColor: Colours.workout_card_background_color,
                          side: BorderSide(
                              color: Colours.workout_card_background_color,
                              width: 2.5),
                          value: isTimerExercise,
                          onChanged: (newValue) => setState(() {
                            isTimerExercise = newValue!;
                          }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    BaseButton(
                        onClick: () => tryToAddExercise(context,
                            titleController.text.toString(), isTimerExercise),
                        buttonText: Strings.add,
                        backgroundColor: Colours.workout_card_background_color,
                        color: Colours.workout_card_foreground_color,
                        buttonSize: Size(double.maxFinite, 45),
                        radius: 8,
                        icon: null,
                        isElevated: true),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void tryToAddExercise(
    BuildContext context,
    String title,
    bool isTimerExercise,
  ) {
    if (titleController.text.isNotEmpty) {
      hasBeenAdd(context, title, isTimerExercise);
    } else {
      showSnackBar(context, Strings.not_full_field_error);
    }
  }

  void hasBeenAdd(
    BuildContext context,
    String title,
    bool isTimerExercise,
  ) {
    widget.exercises.exercises
        .add(ExerciseEntity(title: title, isTimerExercise: isTimerExercise));
    Navigator.of(context).pop(widget.exercises);
  }
}
