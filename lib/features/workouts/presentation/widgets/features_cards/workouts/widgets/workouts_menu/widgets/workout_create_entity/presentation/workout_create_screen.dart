// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/features/home/presentation/widgets/body_home_data.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_card_on_list.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_create_entity/widgets/exercise_item_on_list.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_create_entity/widgets/timer_exercise_item_on_list.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/workouts_menu_screen.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../../core/styles/styles.dart';

class DialogWorkoutCreateScreen extends StatefulWidget {
  FakeWorkoutsDatabase fakeDB;
  WorkoutsMenuScreen workoutsMenuScreen;

  List<ExerciseEntity> _exercises = [];

  bool isEditWorkout = false;

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
  void tryToCreateWorkout(BuildContext context, BuildContext thisContext,
      int index, TextEditingController titleController) {
    widget.isMon = widget.selectedWeekday == Strings.monday ? true : false;
    widget.isTue = widget.selectedWeekday == Strings.tuesday ? true : false;
    widget.isWed = widget.selectedWeekday == Strings.wednesday ? true : false;
    widget.isTh = widget.selectedWeekday == Strings.thursday ? true : false;
    widget.isFri = widget.selectedWeekday == Strings.friday ? true : false;
    widget.isSat = widget.selectedWeekday == Strings.saturday ? true : false;
    widget.isSun = widget.selectedWeekday == Strings.sunday ? true : false;

    bool allFieldsFilled = true;
    for (var exercise in widget._exercises) {
      if (exercise.isExercise) {
        if (exercise.kilograms == 0 ||
            exercise.sets == 0 ||
            exercise.reps == 0) {
          allFieldsFilled = false;
          break;
        }
      } else if (exercise.isTimerExercise) {
        if (exercise.sets == 0) {
          allFieldsFilled = false;
          break;
        }
      }
    }

    if (titleController.text.toString() != "" &&
        (widget.isMon ||
            widget.isTue ||
            widget.isWed ||
            widget.isTh ||
            widget.isFri ||
            widget.isSat ||
            widget.isSun) &&
        widget._exercises.isNotEmpty &&
        allFieldsFilled) {
      createWorkoutInDatabase(
          context: context,
          title: titleController.text.toString(),
          index: index,
          weekday: getNumberWeekday(),
          thisContext: thisContext);
    } else {
      showSnackBar(context, Strings.not_full_field_error);
    }
  }

  int getNumberWeekday() {
    if (widget.isMon) {
      return 1;
    } else if (widget.isTue) {
      return 2;
    } else if (widget.isWed) {
      return 3;
    } else if (widget.isTh) {
      return 4;
    } else if (widget.isFri) {
      return 5;
    } else if (widget.isSat) {
      return 6;
    } else if (widget.isSun) {
      return 7;
    } else {
      return -1;
    }
  }

  createWorkoutInDatabase({
    required BuildContext context,
    required BuildContext thisContext,
    required String title,
    required int index,
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
    List<ExerciseEntity> newExercises = [];
    for (var exercise in widget._exercises) {
      newExercises.add(
        ExerciseEntity(
          title: exercise.title,
          isExercise: exercise.isExercise,
          isTimerExercise: exercise.isTimerExercise,
          kilograms: exercise.kilograms,
          sets: exercise.sets,
          reps: exercise.reps,
          timerTimeMinutes: exercise.timerTimeMinutes,
          timerTimeSeconds: exercise.timerTimeSeconds,
          restTimeInSeconds: exercise.restTimeInSeconds,
          restTimeInMinutes: exercise.restTimeInMinutes,
        ),
      );
    }
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
          cardio: cardio,
          exercises: newExercises),
    );
    if (!widget.isEditWorkout) {
      context.read<WorkoutsMenuBloc>().add(AddWorkoutEvent(widget.fakeDB));
    } else {
      context.read<WorkoutsMenuBloc>().add(UpdateWorkoutEvent(widget.fakeDB));
    }
    Navigator.of(thisContext).pop();
  }

  @override
  Widget build(BuildContext context) {
    final modalRouteData = ModalRoute.of(context)!.settings.arguments as List;
    widget.isEditWorkout = modalRouteData[2] as bool;

    final workoutEntity = modalRouteData[1] as WorkoutEntity;

    int workoutIndex = 0;

    final titleTextFieldController = TextEditingController(
        text: widget.isEditWorkout ? workoutEntity.title : "");

    if (const ListEquality()
        .equals(workoutEntity.exercises, widget._exercises)) {
    } else if (!const ListEquality()
            .equals(workoutEntity.exercises, widget._exercises) &&
        widget._exercises.isEmpty) {
      widget._exercises = workoutEntity.exercises;
    }

    if (widget.isEditWorkout) {
      widget.selectedWeekday = widget.daysOfWeek[workoutEntity.weekday - 1];

      int getIndexIfEdit() {
        for (int i = 0; i < widget.fakeDB.fakeWorkoutEntities.length; i++) {
          if (const ListEquality().equals(
              widget.fakeDB.fakeWorkoutEntities[i].exercises,
              widget._exercises)) {
            return i;
          }
        }
        return 0;
      }

      workoutIndex = getIndexIfEdit();
    }

    final workoutsMenuContext = modalRouteData[0] as BuildContext;

    return Scaffold(
      appBar: widget.mainFrontendData
          .createAppBarWidget(appbarTitle: Strings.creating_appbar),
      body: Wrap(
        children: [
          Container(
              width: widget.screenSize.width,
              margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Card(
                elevation: 4,
                color: Colours.workout_card_background_color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colours.workoutCardForegroundColor,
                      ),
                      width: widget.screenSize.width / 1.5,
                      margin: const EdgeInsets.all(30),
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: titleTextFieldController,
                        cursorColor: Colours.workout_card_background_color,
                        textAlign: TextAlign.center,
                        style: Styles.hint_text_style_create_workout,
                        decoration: InputDecoration(
                          isDense: true,
                          hintStyle: Styles.hint_text_style_create_workout,
                          hintText: Strings.title,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colours.workout_card_background_color,
                                width: 3),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colours.workout_card_background_color,
                                width: 3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: widget.screenSize.width / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colours.workoutCardForegroundColor,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: widget.screenSize.height / 4,
                            child: ListView.builder(
                              itemCount: widget._exercises.length,
                              itemBuilder: (context, index) {
                                if (widget._exercises[index].isExercise) {
                                  return ExerciseItemOnList(
                                    context,
                                    widget.screenSize,
                                    index,
                                    widget._exercises,
                                    widget.isEditWorkout,
                                    onRemoveItem: () {
                                      removeItem(index);
                                    },
                                  );
                                } else if (widget
                                    ._exercises[index].isTimerExercise) {
                                  return TimerExerciseItemOnList(
                                    context,
                                    widget.screenSize,
                                    index,
                                    widget._exercises,
                                    onRemoveItem: () {
                                      removeItem(index);
                                    },
                                  );
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          BaseButton(
                            onClick: () => goToAddExercise(context),
                            buttonText: Strings.add,
                            icon: null,
                            buttonSize: Size(widget.screenSize.width / 1.5,
                                widget.screenSize.height / 15),
                            isElevated: true,
                            radius: 8,
                            backgroundColor:
                                Colours.workout_card_background_color,
                            color: Colours.workoutCardForegroundColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: widget.screenSize.width / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colours.workoutCardForegroundColor,
                      ),
                      child: DropdownButtonFormField<String>(
                        isDense: true,
                        dropdownColor: Colours.workoutCardForegroundColor,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colours.workoutCardForegroundColor,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colours.workoutCardForegroundColor,
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
                    const SizedBox(
                      height: 30,
                    ),
                    BaseButton(
                      onClick: () => tryToCreateWorkout(workoutsMenuContext,
                          context, workoutIndex, titleTextFieldController),
                      buttonText: Strings.done,
                      icon: null,
                      isElevated: true,
                      radius: 8,
                      backgroundColor: Colours.workoutCardForegroundColor,
                      color: Colours.workout_card_background_color,
                      buttonSize: Size(widget.screenSize.width / 1.5,
                          widget.screenSize.height / 15),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void removeItem(int index) {
    setState(() {
      widget._exercises.removeAt(index);
    });
  }

  void goToAddExercise(BuildContext buildContext) async {
    final ExerciseEntity exercise = await Navigator.pushNamed(
            context, "/workouts_menu/create_workout/add_exercise/")
        as ExerciseEntity;

    setState(() {
      widget._exercises.add(exercise);
    });
  }
}

String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}
