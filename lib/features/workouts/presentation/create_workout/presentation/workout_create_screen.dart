// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/presentation/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/widgets/exercise_item_on_list.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/widgets/timer_exercise_item_on_list.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/strings/strings.dart';
import '../../../../../core/styles/styles.dart';

class CreateWorkoutScreen extends StatefulWidget {
  List<ExerciseEntity> _exercises = [];
  bool isEditWorkout = false;

  final Size screenSize;

  String? weekdayString;
  int? weekdayNum;

  final List<String> daysOfWeek = [
    Strings.monday,
    Strings.tuesday,
    Strings.wednesday,
    Strings.thursday,
    Strings.friday,
    Strings.saturday,
    Strings.sunday,
  ];

  CreateWorkoutScreen({super.key, required this.screenSize});

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  Future<void> tryToCreateWorkout(
      int? weekday,
      BuildContext menuContext,
      BuildContext thisContext,
      int id,
      TextEditingController titleController) async {
    final depends = AppDependsProvider.of(thisContext);

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

    if (titleController.text.toString() != "" &&
        (widget.weekdayNum != null) &&
        widget._exercises.isNotEmpty) {
      try {
        final storage = depends.secureStorage;

        final tokenJson = await storage.read(AppConsts.tokenKey);
        final tokenMap = jsonDecode(tokenJson);
        final token = tokenMap['access_token'];

        if (!widget.isEditWorkout) {
          await depends.workoutsRepository.createWorkout(
              titleController.text.toString(), weekday!, newExercises, token);
        } else {
          await depends.workoutsRepository.updateWorkout(
              titleController.text.toString(),
              weekday,
              newExercises,
              id,
              token);
        }

        menuContext.read<WorkoutsMenuBloc>().add(UpdateWorkoutEvent());
        Navigator.of(menuContext).pop();
      } on Object catch (error, stack) {
        throw Exception("Error: $error, StackTrace: $stack");
      }
    } else {
      showSnackBar(menuContext, Strings.not_full_field_error);
    }
  }

  int getNumberWeekday(String weekday) {
    if (weekday == Strings.monday) {
      return 1;
    } else if (weekday == Strings.tuesday) {
      return 2;
    } else if (weekday == Strings.wednesday) {
      return 3;
    } else if (weekday == Strings.thursday) {
      return 4;
    } else if (weekday == Strings.friday) {
      return 5;
    } else if (weekday == Strings.saturday) {
      return 6;
    } else if (weekday == Strings.sunday) {
      return 7;
    } else {
      return -1;
    }
  }

  late TextEditingController titleTextFieldController;

  @override
  void initState() {
    super.initState();
    titleTextFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final modalRouteData = ModalRoute.of(context)!.settings.arguments as List;

    final workoutsMenuContext = modalRouteData[0] as BuildContext;
    final workoutEntity = modalRouteData[1] as WorkoutEntity;
    widget.isEditWorkout = modalRouteData[2] as bool;

    int workoutId = 0;

    if (widget.isEditWorkout) {
      if (!const ListEquality()
              .equals(workoutEntity.exercises, widget._exercises) &&
          widget._exercises.isEmpty) {
        widget._exercises = workoutEntity.exercises;
      }

      widget.weekdayString = widget.daysOfWeek[workoutEntity.weekday - 1];
      widget.weekdayNum = getNumberWeekday(widget.weekdayString!);

      titleTextFieldController.text =
          widget.isEditWorkout ? workoutEntity.title.toString() : "";

      workoutId = workoutEntity.id!;
    }

    return Scaffold(
      appBar: createAppBarWidget(
          appbarTitle: Strings.creating_appbar, context: context),
      body: SingleChildScrollView(
        child: Container(
            width: widget.screenSize.width,
            margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Card(
              elevation: 4,
              color: Colours.workout_card_background_color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colours.workoutCardForegroundColor,
                    ),
                    width: widget.screenSize.width / 1.5,
                    margin: const EdgeInsets.all(30),
                    padding: const EdgeInsets.all(8),
                    child: Center(
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
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
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
                                  widget.isEditWorkout,
                                  onRemoveItem: () {
                                    removeItem(index);
                                  },
                                );
                              }
                              return const CircularProgressIndicator();
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
                      decoration: const InputDecoration(
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
                      value: widget.weekdayString,
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
                          widget.weekdayNum = getNumberWeekday(newValue!);
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BaseButton(
                    onClick: () => tryToCreateWorkout(
                        widget.weekdayNum,
                        workoutsMenuContext,
                        context,
                        workoutId,
                        titleTextFieldController),
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
      ),
    );
  }

  void removeItem(int index) {
    setState(() {
      widget._exercises.removeAt(index);
    });
  }

  void goToAddExercise(BuildContext buildContext) async {
    final ExerciseOnListEntity? exercise = await Navigator.pushNamed(
            context, "/workouts_menu/create_workout/add_exercise/")
        as ExerciseOnListEntity?;

    if (exercise != null) {
      setState(() {
        ExerciseEntity newExercise = ExerciseEntity(
            title: exercise.title,
            isExercise: exercise.isExercise,
            isTimerExercise: exercise.isExercise ? false : true);
        widget._exercises.add(newExercise);
      });
    } else {
      return null;
    }
  }
}

String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}
