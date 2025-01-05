import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/new_workout_button.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/material.dart';

class DialogWorkoutCreateScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  createWorkoutInDatabase() {
    print(FakeWorkoutsDatabase().fakeWorkoutEntities.length);
    FakeWorkoutsDatabase()
      ..fakeWorkoutEntities.add(
        WorkoutEntity(
          title: controller.text.toString(),
        ),
      );
    print(FakeWorkoutsDatabase().fakeWorkoutEntities.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Название"),
            TextField(
              controller: controller,
            ),
            Text("День недели"),
            Row(
              children: [
                Column(
                  children: [
                    Text("Понедельник"),
                    Checkbox(value: false, onChanged: (bool? newValue) {})
                  ],
                ),
                Column(
                  children: [
                    Text("Вт"),
                    Checkbox(value: false, onChanged: (bool? newValue) {})
                  ],
                ),
                Column(
                  children: [
                    Text("Ср"),
                    Checkbox(value: false, onChanged: (bool? newValue) {})
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text("Чт"),
                    Checkbox(value: false, onChanged: (bool? newValue) {})
                  ],
                ),
                Column(
                  children: [
                    Text("Пн"),
                    Checkbox(value: false, onChanged: (bool? newValue) {})
                  ],
                ),
                Column(
                  children: [
                    Text("Сб"),
                    Checkbox(value: false, onChanged: (bool? newValue) {})
                  ],
                ),
                Column(
                  children: [
                    Text("Вс"),
                    Checkbox(value: false, onChanged: (bool? newValue) {})
                  ],
                ),
              ],
            ),
            BaseButton(
                onClick: () {
                  createWorkoutInDatabase();
                },
                buttonText: "Cоздать",
                icon: null,
                isElevated: true),
          ],
        ),
      ),
    );
  }
}
