import 'dart:ui';

import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/features/home/presentation/widgets/body_home_data.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workout_button_widget.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/dialog_create_entity/bloc/dialog_create_entity_cubit.dart';
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

  List<ExerciseEntity> exercises = [];

  void tryToCreateWorkout(BuildContext context) {
    print(widget.selectedWeekday);

    widget.isMon = widget.selectedWeekday == Strings.monday ? true : false;
    widget.isTue = widget.selectedWeekday == Strings.tuesday ? true : false;
    widget.isWed = widget.selectedWeekday == Strings.wednesday ? true : false;
    widget.isTh = widget.selectedWeekday == Strings.thursday ? true : false;
    widget.isFri = widget.selectedWeekday == Strings.friday ? true : false;
    widget.isSat = widget.selectedWeekday == Strings.saturday ? true : false;
    widget.isSun = widget.selectedWeekday == Strings.sunday ? true : false;

    print(titleTextFieldController.text.toString());

    if (titleTextFieldController.text.toString() != "" &&
        (widget.isMon ||
            widget.isTue ||
            widget.isWed ||
            widget.isTh ||
            widget.isFri ||
            widget.isSat ||
            widget.isSun)) {
      print(widget.isMon);
      createWorkoutInDatabase(
          context: context,
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
    required BuildContext context,
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
    try {
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
      widget.fakeDB.fakeWorkoutExercises.add(exercises);
      print(widget.fakeDB.fakeWorkoutEntities.length);
      context.read<WorkoutsMenuBloc>().add(AddWorkoutEvent(widget.fakeDB));
    } catch (e) {
      print("Handled error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final BuildContext workoutsMenuContext =
        ModalRoute.of(context)!.settings.arguments as BuildContext;

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
                        controller: titleTextFieldController,
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
                            height: widget.screenSize.height / 4,
                            child: BlocBuilder<DialogCreateEntityCubit,
                                List<ExerciseEntity>>(
                              builder: (context, exercises) {

                                this.exercises = exercises;

                                return ListView.builder(
                                    itemCount: exercises.length,
                                    itemBuilder: (context, index) {
                                      return Text(exercises[index].title);
                                    });
                              },
                            ),
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
                      onClick: () => tryToCreateWorkout(workoutsMenuContext),
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

  void addExercise() async {
    final selectedExercise = await Navigator.pushNamed(
        context, "/workouts_menu/create_workout/add_exercise/");
    if (selectedExercise != null) {
      context
          .read<DialogCreateEntityCubit>()
          .addItem(selectedExercise as ExerciseEntity);
    }
  }
}
