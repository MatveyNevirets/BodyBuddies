import 'dart:async';

import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/exercises_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../../../home/presentation/widgets/body_home_data.dart';

class AddExerciseScreen extends StatefulWidget {
  final BodyHomeData mainFrontendData;

  Exercises exercises;

  AddExerciseScreen(
      {super.key, required this.mainFrontendData, required this.exercises});

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  List<ExerciseEntity> filteredExercises = [];

  final searchTextFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchExercises();
    searchTextFieldController.addListener(searchExercises);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.mainFrontendData
          .createAppBarWidget(appbarTitle: Strings.change_exercise),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchTextFieldController,
              decoration: InputDecoration(hintText: "Поиск"),
            ),
            Container(
              child: Expanded(
                child: filteredExercises.isNotEmpty
                    ? ListView.builder(
                        itemCount: filteredExercises.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => addExercise(context, index),
                            child: Card(
                              color: Colours.workout_card_foreground_color,
                              child: ListTile(
                                title: Text(filteredExercises[index].title),
                              ),
                            ),
                          );
                        })
                    : Text("Нема дата"),
              ),
            ),
            BaseButton(
                onClick: () => addYourExercise(context),
                buttonText: "Добавить свое",
                icon: null,
                isElevated: true),
          ],
        ),
      ),
    );
  }

  void addExercise(BuildContext context, int index) {
    Navigator.of(context).pop(filteredExercises[index]);
  }

  void searchExercises() {
    String query =
        searchTextFieldController.text.toLowerCase().replaceAll(" ", "");

    if (query.isNotEmpty) {
      filteredExercises =
          widget.exercises.exercises.where((ExerciseEntity entity) {
        return entity.title.toLowerCase().replaceAll(" ", "").contains(query);
      }).toList();
    } else if (query.isEmpty) {
      filteredExercises = widget.exercises.exercises;
    }
    setState(() {});
  }

  void addYourExercise(BuildContext context) {
    final createdExercises = Navigator.of(context).pushNamed(
        "/workouts_menu/create_workout/add_exercise/add_your_exercise/");

    createdExercises
        .whenComplete(complete(context) as FutureOr<void> Function());
  }

  Future<void> complete(BuildContext context) async {
    setState(() {
      widget.exercises = ModalRoute.of(context)?.settings.arguments as Exercises;
    });
  }
}
