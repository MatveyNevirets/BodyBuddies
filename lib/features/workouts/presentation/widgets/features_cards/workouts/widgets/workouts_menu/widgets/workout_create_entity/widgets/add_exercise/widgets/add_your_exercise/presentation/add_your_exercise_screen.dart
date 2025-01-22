import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../../../../../home/presentation/widgets/body_home_data.dart';
import '../../../../../../../domain/exercises_database.dart';

class AddYourExerciseScreen extends StatelessWidget {
  final BodyHomeData mainFrontendData;
  final Exercises exercises;

  AddYourExerciseScreen(
      {super.key, required this.mainFrontendData, required this.exercises});

  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainFrontendData.createAppBarWidget(
          appbarTitle: Strings.creating_appbar),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: "Введите название"),
            ),
            BaseButton(
                onClick: () =>
                    hasBeenAdd(context, titleController.text.toString()),
                buttonText: Strings.add,
                icon: null,
                isElevated: true),
          ],
        ),
      ),
    );
  }

  void hasBeenAdd(BuildContext context, String title) {
    print(exercises.exercises.length);
    exercises.exercises.add(ExerciseEntity(title: title));
    print(exercises.exercises.length);

    Navigator.of(context).pop(exercises);
  }
}
