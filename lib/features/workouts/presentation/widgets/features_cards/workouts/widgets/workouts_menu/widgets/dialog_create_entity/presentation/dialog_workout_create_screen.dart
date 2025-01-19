import 'dart:ui';

import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/features/home/presentation/widgets/body_home_data.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workout_button_widget.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/dialog_create_entity/widgets/exercise_card_widget.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/new_workout_button.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/workouts_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../../core/styles/styles.dart';
import '../../../../workout_container_text.dart';

class DialogWorkoutCreateScreen extends StatefulWidget {
  FakeWorkoutsDatabase fakeDB;
  WorkoutsMenuScreen workoutsMenuScreen;

  final VoidCallback onWorkoutCreated;
  final Size screenSize;
  final BodyHomeData mainFrontendData;

  final List<String> daysOfWeek = [
    Strings.monday,
    Strings.tuesday,
    Strings.wednesday,
    Strings.thursday,
    Strings.friday,
    Strings.saturday,
    Strings.sunday,
  ];

  String? selectedWeekday;

  DialogWorkoutCreateScreen(
      {super.key,
      required this.fakeDB,
      required this.workoutsMenuScreen,
      required this.onWorkoutCreated,
      required this.screenSize,
      required this.mainFrontendData});

  bool isMon = false,
      isTue = false,
      isWed = false,
      isTh = false,
      isFri = false,
      isSat = false,
      isSun = false;

  @override
  State<DialogWorkoutCreateScreen> createState() =>
      _DialogWorkoutCreateScreenState();
}

class _DialogWorkoutCreateScreenState extends State<DialogWorkoutCreateScreen> {
  TextEditingController titleTextFieldController = TextEditingController();

  void tryToCreateWorkout(BuildContext context) {
    if (titleTextFieldController.text.toString() != "" &&
        (widget.isMon ||
            widget.isTue ||
            widget.isWed ||
            widget.isTh ||
            widget.isFri ||
            widget.isSat ||
            widget.isSun)) {
      createWorkoutInDatabase(
          title: titleTextFieldController.text.toString(),
          weekday: getNumberWeekday());

      widget.onWorkoutCreated.call();
      print("Send");
    } else {
      showSnackBar(context, Strings.not_full_field_error);
    }
  }

  int getNumberWeekday() {
    if (widget.isMon)
      return 1;
    else if (widget.isTue)
      return 2;
    else if (widget.isWed)
      return 3;
    else if (widget.isTh)
      return 4;
    else if (widget.isFri)
      return 5;
    else if (widget.isSat)
      return 6;
    else if (widget.isSun)
      return 7;
    else
      return -1;
  }

  createWorkoutInDatabase({
    required String title,
    int weekday = -1,
    bool abs = false,
    bool shoulders = false,
    bool legs = false,
    bool triceps = false,
    bool biceps = false,
    bool back = false,
    bool forearms = false,
    bool chest = false,
    bool cardio = false,
  }) {
    print(widget.fakeDB.fakeWorkoutEntities.length);
    widget.fakeDB.fakeWorkoutEntities.add(
      WorkoutEntity(
          title: title,
          weekday: weekday,
          abs: abs,
          shoulders: shoulders,
          legs: legs,
          triceps: triceps,
          biceps: biceps,
          back: back,
          forearms: forearms,
          chest: chest,
          cardio: cardio),
    );
    widget.fakeDB.fakeWorkoutExercises.add(
      [
        ExerciseEntity(
            title: "Гарик пожизненный на бицеас",
            isExercise: true,
            reps: 25,
            sets: 4),
        ExerciseEntity(
            title: "Жим", isExercise: true, reps: 15, sets: 4, kilograms: 55),
        ExerciseEntity(title: "Да махи", isExercise: true, reps: 13, sets: 4),
        ExerciseEntity(
            title: "Присед",
            isExercise: true,
            reps: 15,
            sets: 4,
            kilograms: 40),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ExerciseEntity> exercises = [
      ExerciseEntity(title: "title")
    ];
    // ModalRoute.of(context)!.settings.arguments as List<ExerciseEntity>
    return Scaffold(
      appBar: widget.mainFrontendData
          .createAppBarWidget(appbarTitle: Strings.creating_appbar),
      body: Wrap(
        children: [
          Container(
              width: widget.screenSize.width,
              margin: EdgeInsets.all(20),
              child: Card(
                elevation: 4,
                color: Colours.workout_card_background_color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colours.workout_card_foreground_color,
                      ),
                      width: widget.screenSize.width / 1.5,
                      margin: EdgeInsets.all(30),
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        cursorColor: Colours.workout_card_background_color,
                        textAlign: TextAlign.center,
                        style: Styles.hint_text_style_create_workout,
                        decoration: InputDecoration(
                          isDense: true,
                          hintStyle: Styles.hint_text_style_create_workout,
                          hintText: Strings.title,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colours.workout_card_background_color,
                                width: 3),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colours.workout_card_background_color,
                                width: 3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      width: widget.screenSize.width / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colours.workout_card_foreground_color,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: widget.screenSize.height/4,
                            child:
                                ListView.builder(itemCount: exercises.length, itemBuilder: (context, index) {
                              return Text(exercises[index].title);
                            }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BaseButton(
                            onClick: () => addExercise(),
                            buttonText: Strings.add,
                            icon: null,
                            buttonSize: Size(widget.screenSize.width / 1.5,
                                widget.screenSize.height / 15),
                            isElevated: true,
                            radius: 8,
                            backgroundColor:
                                Colours.workout_card_background_color,
                            color: Colours.workout_card_foreground_color,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      width: widget.screenSize.width / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colours.workout_card_foreground_color,
                      ),
                      child: DropdownButtonFormField<String>(
                        isDense: true,
                        dropdownColor: Colours.workout_card_foreground_color,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colours.workout_card_foreground_color,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colours.workout_card_foreground_color,
                            ),
                          ),
                        ),
                        value: widget.selectedWeekday,
                        hint: Center(
                            child: Text(
                          Strings.day,
                          textAlign: TextAlign.center,
                          style: Styles.hint_text_style_create_workout,
                        )),
                        items: widget.daysOfWeek.map((String day) {
                          return DropdownMenuItem<String>(
                            value: day,
                            child: Center(
                                child: Text(
                              day,
                              style: Styles.hint_text_style_create_workout,
                            )),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            widget.selectedWeekday = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    BaseButton(
                      onClick: () {},
                      buttonText: Strings.button_done_text,
                      icon: null,
                      isElevated: true,
                      radius: 8,
                      backgroundColor: Colours.workout_card_foreground_color,
                      color: Colours.workout_card_background_color,
                      buttonSize: Size(widget.screenSize.width / 1.5,
                          widget.screenSize.height / 15),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void addExercise() => Navigator.pushNamed(
      context, "/workouts_menu/create_workout/add_exercise/");
}
