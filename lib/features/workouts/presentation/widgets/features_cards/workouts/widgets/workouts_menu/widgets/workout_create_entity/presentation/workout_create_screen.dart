import 'dart:ui';

import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/features/home/presentation/widgets/body_home_data.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workout_button_widget.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_create_entity/widgets/exercise_item_on_list.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_create_entity/widgets/rest_item_on_list.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/new_workout_button.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/workouts_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../../core/styles/styles.dart';
import '../../../../workout_container_text.dart';
import '../bloc/workout_create_entity_cubit.dart';
import '../widgets/timer_exercise_item_on_list.dart';

class DialogWorkoutCreateScreen extends StatefulWidget {
  FakeWorkoutsDatabase fakeDB;
  WorkoutsMenuScreen workoutsMenuScreen;

  List<ExerciseEntity> _exercises = [];

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
  final titleTextFieldController = TextEditingController();

  void tryToCreateWorkout(BuildContext context, BuildContext thisContext) {
    widget.isMon = widget.selectedWeekday == Strings.monday ? true : false;
    widget.isTue = widget.selectedWeekday == Strings.tuesday ? true : false;
    widget.isWed = widget.selectedWeekday == Strings.wednesday ? true : false;
    widget.isTh = widget.selectedWeekday == Strings.thursday ? true : false;
    widget.isFri = widget.selectedWeekday == Strings.friday ? true : false;
    widget.isSat = widget.selectedWeekday == Strings.saturday ? true : false;
    widget.isSun = widget.selectedWeekday == Strings.sunday ? true : false;

    if (titleTextFieldController.text.toString() != "" &&
        (widget.isMon ||
            widget.isTue ||
            widget.isWed ||
            widget.isTh ||
            widget.isFri ||
            widget.isSat ||
            widget.isSun) &&
        widget._exercises.length != 0) {
      createWorkoutInDatabase(
          context: context,
          title: titleTextFieldController.text.toString(),
          weekday: getNumberWeekday(),
          thisContext: thisContext);

      widget.onWorkoutCreated.call();
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
    required BuildContext thisContext,
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
          exercises: widget._exercises),
    );
    context.read<WorkoutsMenuBloc>().add(AddWorkoutEvent(widget.fakeDB));
    thisContext.read<DialogCreateEntityCubit>().resetExercises();
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
                        color: Colours.workout_card_foreground_color,
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
                      padding: const EdgeInsets.all(16),
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
                                widget._exercises = exercises;
                                for (int i = 0;
                                    i < widget._exercises.length;
                                    i++) {
                                  print(widget._exercises[i].kilograms);
                                }
                                return buildExerciseCard(
                                    widget._exercises, context);
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
                            color: Colours.workout_card_foreground_color,
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
                    const SizedBox(
                      height: 30,
                    ),
                    BaseButton(
                      onClick: () =>
                          tryToCreateWorkout(workoutsMenuContext, context),
                      buttonText: Strings.done,
                      icon: null,
                      isElevated: true,
                      radius: 8,
                      backgroundColor: Colours.workout_card_foreground_color,
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

  ListView buildExerciseCard(
      List<ExerciseEntity> exercises, BuildContext context) {
    return ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          if (exercises[index].isExercise) {
            for (int i = 0; i < widget._exercises.length; i++) {
              print(widget._exercises[i].kilograms);
            }
            return buildExerciseItem(context, widget.screenSize, exercises,
                index, widget._exercises);
          } else if (exercises[index].isRest) {
            return buildRestItem(
                widget.screenSize, exercises, index, widget._exercises);
          } else if (exercises[index].isTimerExercise) {
            return buildTimerExerciseItem(
                widget.screenSize, exercises, index, widget._exercises);
          }
        });
  }

  void updateItem(int index, ExerciseEntity exercises) {
    context.read<DialogCreateEntityCubit>().updateItem(index, exercises);
  }

  void goToAddExercise(BuildContext buildContext) {
    Navigator.pushNamed(context, "/workouts_menu/create_workout/add_exercise/",
        arguments: buildContext);
  }

  void removeExercise(int index) {
    context.read<DialogCreateEntityCubit>().removeItem(index);
  }
}

String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return text.substring(0, maxLength) + '...';
  }
}
