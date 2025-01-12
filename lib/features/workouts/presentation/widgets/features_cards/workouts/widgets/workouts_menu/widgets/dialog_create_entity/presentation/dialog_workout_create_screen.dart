import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/new_workout_button.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/workouts_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../../core/strings/strings.dart';
import '../../../../workout_container_text.dart';

class DialogWorkoutCreateScreen extends StatefulWidget {
  FakeWorkoutsDatabase fakeDB;
  WorkoutsMenuScreen workoutsMenuScreen;

  final VoidCallback onWorkoutCreated;

  DialogWorkoutCreateScreen({required this.fakeDB,
    required this.workoutsMenuScreen,
    required this.onWorkoutCreated});

  bool isMon = false,
      isTue = false,
      isWed = false,
      isTh = false,
      isFri = false,
      isSat = false,
      isSun = false;

  String? selectedWeekday;

  List<String> weekdays = [
    Strings.monday,
    Strings.tuesday,
    Strings.wednesday,
    Strings.thursday,
    Strings.friday,
    Strings.saturday,
    Strings.sunday,
  ];

  @override
  State<DialogWorkoutCreateScreen> createState() =>
      _DialogWorkoutCreateScreenState();
}

class _DialogWorkoutCreateScreenState extends State<DialogWorkoutCreateScreen> {
  TextEditingController controller = TextEditingController();

  void tryToCreateWorkout(BuildContext context) {
    if (controller.text.toString() != "" &&
        (widget.isMon ||
            widget.isTue ||
            widget.isWed ||
            widget.isTh ||
            widget.isFri ||
            widget.isSat ||
            widget.isSun)) {
      createWorkoutInDatabase(
          title: controller.text.toString(),
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
            title: "Жим",
            isExercise: true,
            reps: 15,
            sets: 4,
            kilograms: 55),
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
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text("Название"),
            Container(
              margin: EdgeInsets.all(32),
              child: TextField(
                controller: controller,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Выберите день недели',
                    errorText: state.hasError ? state.errorText : null,
                  ),
                  isEmpty: widget.selectedWeekday == null,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: widget.selectedWeekday,
                      isDense: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          widget.selectedWeekday = newValue;
                          state.didChange(newValue);
                        });
                      },
                      items: widget.weekdays.map((String day) {
                        return DropdownMenuItem<String>(
                          value: day,
                          child: Text(day),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),


            // Text("День недели"),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Column(
            //       children: [
            //         Text("Пн"),
            //         Checkbox(
            //             value: widget.isMon,
            //             onChanged: (bool? newValue) {
            //               setState(() {
            //                 widget.isMon = newValue!;
            //               });
            //             })
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text("Вт"),
            //         Checkbox(
            //             value: widget.isTue,
            //             onChanged: (bool? newValue) {
            //               setState(() {
            //                 widget.isTue = newValue!;
            //               });
            //             })
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text("Ср"),
            //         Checkbox(
            //             value: widget.isWed,
            //             onChanged: (bool? newValue) {
            //               setState(() {
            //                 widget.isWed = newValue!;
            //               });
            //             })
            //       ],
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Column(
            //       children: [
            //         Text("Чт"),
            //         Checkbox(
            //             value: widget.isTh,
            //             onChanged: (bool? newValue) {
            //               setState(() {
            //                 widget.isTh = newValue!;
            //               });
            //             })
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text("Пт"),
            //         Checkbox(
            //             value: widget.isFri,
            //             onChanged: (bool? newValue) {
            //               setState(() {
            //                 widget.isFri = newValue!;
            //               });
            //             })
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text("Сб"),
            //         Checkbox(
            //             value: widget.isSat,
            //             onChanged: (bool? newValue) {
            //               setState(() {
            //                 widget.isSat = newValue!;
            //               });
            //             })
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text("Вс"),
            //         Checkbox(
            //             value: widget.isSun,
            //             onChanged: (bool? newValue) {
            //               setState(() {
            //                 widget.isSun = newValue!;
            //               });
            //             })
            //       ],
            //     ),
            //   ],
            // ),
            SizedBox(height: 30,),
            BaseButton(
                onClick: () => tryToCreateWorkout(context),
                buttonText: "Cоздать",
                icon: null,
                isElevated: true),
          ],
        ),
      ),
    );
  }
}
