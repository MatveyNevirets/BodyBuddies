// ignore_for_file: must_be_immutable

import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/features/home/presentation/widgets/body_home_data.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/workouts_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../../core/styles/styles.dart';

class DialogWorkoutCreateScreen extends StatefulWidget {
  FakeWorkoutsDatabase fakeDB;
  WorkoutsMenuScreen workoutsMenuScreen;

  final List<ExerciseEntity> _exercises = [];

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
  final titleTextFieldController = TextEditingController();

  final List<TextEditingController> weightControllers = [];

  @override
  void dispose() {
    // TODO: implement dispose
    for (var controllers in weightControllers) {
      controllers.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; widget._exercises.length > i; i++) {
      weightControllers.add(TextEditingController());
    }
  }

  void addControllers() {
    weightControllers.add(TextEditingController());
  }

  void tryToCreateWorkout(BuildContext context, BuildContext thisContext) {
    widget.isMon = widget.selectedWeekday == Strings.monday ? true : false;
    widget.isTue = widget.selectedWeekday == Strings.tuesday ? true : false;
    widget.isWed = widget.selectedWeekday == Strings.wednesday ? true : false;
    widget.isTh = widget.selectedWeekday == Strings.thursday ? true : false;
    widget.isFri = widget.selectedWeekday == Strings.friday ? true : false;
    widget.isSat = widget.selectedWeekday == Strings.saturday ? true : false;
    widget.isSun = widget.selectedWeekday == Strings.sunday ? true : false;

    // bool allFieldsFilled = true;
    // for (var exercise in widget._exercises) {
    //   if (exercise.kilograms == 0 || exercise.sets == 0 || exercise.reps == 0) {
    //     allFieldsFilled = false;
    //     break;
    //   }
    // }

    if (titleTextFieldController.text.toString() != "" &&
        (widget.isMon ||
            widget.isTue ||
            widget.isWed ||
            widget.isTh ||
            widget.isFri ||
            widget.isSat ||
            widget.isSun) &&
        widget._exercises.isNotEmpty) {
      createWorkoutInDatabase(
          context: context,
          title: titleTextFieldController.text.toString(),
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
          isRest: exercise.isRest,
          isTimerExercise: exercise.isTimerExercise,
          kilograms: double.tryParse(
                  weightControllers[widget._exercises.indexOf(exercise)]
                      .text
                      .toString()) ??
              0,
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
    context.read<WorkoutsMenuBloc>().add(AddWorkoutEvent(widget.fakeDB));
    Navigator.of(thisContext).pop();
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
                                      addControllers();
                                      return buildExerciseItem(
                                          context,
                                          widget.screenSize,
                                          index,
                                          widget._exercises,
                                          weightControllers[index]);
                                    } else if (widget
                                        ._exercises[index].isRest) {
                                      return buildRestItem(widget.screenSize,
                                          widget._exercises, index);
                                    } else if (widget
                                        ._exercises[index].isTimerExercise) {
                                      return buildTimerExerciseItem(
                                          widget.screenSize,
                                          widget._exercises,
                                          index);
                                    }
                                    return null;
                                  })),
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
                      onClick: () =>
                          tryToCreateWorkout(workoutsMenuContext, context),
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

  buildExerciseItem(
    BuildContext context,
    Size screenSize,
    int index,
    List<ExerciseEntity> exercises,
    TextEditingController weightController,
  ) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colours.workout_card_background_color,
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              buildHeaderCardWidget(screenSize, exercises, index),
              const SizedBox(height: 6),
              buildExerciseInputFields(
                  context, screenSize, exercises, index, weightController),
              const SizedBox(
                height: 12,
              ),
              buildRestOfSetsInputFields(context, screenSize, exercises, index),
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
                onChanged: (value) {
                  exercises[index].timerTimeMinutes = int.parse(value);
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
                onChanged: (value) {
                  exercises[index].restTimeInSeconds = int.parse(value);
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
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: screenSize.width / 7,
          height: 30,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colours.workoutCardForegroundColor,
              borderRadius: BorderRadius.circular(4)),
          child: TextField(
            // controller: weightNotifier[index],
            // onChanged: (value) => _updateKg(index, weightControllers[index]),
            keyboardType: TextInputType.number,
            maxLength: 4,
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
            onChanged: (value) {
              exercises[index].sets = int.parse(value);
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
            onChanged: (value) {
              exercises[index].reps = int.parse(value);
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
                truncateText(exercises[index].title, 13),
                style: Styles.hint_text_field_fill_workout,
              )),
        ),
      ],
    );
  }

  void updateItem(int index, ExerciseEntity exercises) {}

  void goToAddExercise(BuildContext buildContext) async {
    final ExerciseEntity exercise = await Navigator.pushNamed(
            context, "/workouts_menu/create_workout/add_exercise/")
        as ExerciseEntity;

    setState(() {
      widget._exercises.add(exercise);
      addControllers();
    });
  }

  void removeExercise(int index) {}
}

String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}

Widget buildRestItem(
    Size screenSize, List<ExerciseEntity> exercises, int index) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colours.workout_card_background_color,
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image:
                      const AssetImage("lib/assets/images/workout_image.png"),
                  height: screenSize.height / 18,
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colours.workoutCardForegroundColor,
                          borderRadius: BorderRadius.circular(4)),
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 4),
                      height: screenSize.height / 25,
                      child: Text(
                        textAlign: TextAlign.center,
                        truncateText(exercises[index].title, 13),
                        style: Styles.hint_text_field_fill_workout,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenSize.width / 5,
                  height: 30,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colours.workoutCardForegroundColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextField(
                    onChanged: (value) {
                      exercises[index].restTimeInMinutes = int.parse(value);
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
                const SizedBox(
                  width: 30,
                ),
                Container(
                  width: screenSize.width / 5,
                  height: 30,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colours.workoutCardForegroundColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextField(
                    onChanged: (value) {
                      exercises[index].restTimeInSeconds = int.parse(value);
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
        ),
      ),
      const SizedBox(
        height: 12,
      ),
    ],
  );
}

Widget buildTimerExerciseItem(
    Size screenSize, List<ExerciseEntity> exercises, int index) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colours.workout_card_background_color,
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image:
                      const AssetImage("lib/assets/images/workout_image.png"),
                  height: screenSize.height / 18,
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colours.workoutCardForegroundColor,
                          borderRadius: BorderRadius.circular(4)),
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 4),
                      height: screenSize.height / 25,
                      child: Text(
                        textAlign: TextAlign.center,
                        truncateText(exercises[index].title, 13),
                        style: Styles.hint_text_field_fill_workout,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenSize.width / 5,
                  height: 30,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colours.workoutCardForegroundColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextField(
                    onChanged: (value) {
                      exercises[index].timerTimeMinutes = int.parse(value);
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
                const SizedBox(
                  width: 30,
                ),
                Container(
                  width: screenSize.width / 5,
                  height: 30,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colours.workoutCardForegroundColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextField(
                    onChanged: (value) {
                      exercises[index].timerTimeSeconds = int.parse(value);
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
        ),
      ),
      const SizedBox(
        height: 12,
      ),
    ],
  );
}
