import 'dart:async';

import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/exercises_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../../../../core/strings/strings.dart';
import '../../../../../../../../../../../../../core/styles/styles.dart';
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
        decoration: BoxDecoration(
            //color: Colours.workout_card_background_color,
            borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.all(16),
        child: Card(
          color: Colours.workout_card_background_color,
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colours.workout_card_foreground_color,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                    controller: searchTextFieldController,
                    cursorColor: Colours.workout_card_background_color,
                    textAlign: TextAlign.start,
                    style: Styles.hint_text_style_create_workout,
                    decoration: InputDecoration(
                      isDense: true,
                      hintStyle: Styles.hint_text_style_create_workout,
                      hintText: Strings.search,
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
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: filteredExercises.isNotEmpty
                      ? buildHasDataList()
                      : buildHasntDataContainer(),
                ),
                SizedBox(
                  height: 16,
                ),
                BaseButton(
                    onClick: () => addYourExercise(context),
                    buttonText: Strings.add_yourself,
                    backgroundColor: Colours.workout_card_foreground_color,
                    color: Colours.workout_card_background_color,
                    radius: 8,
                    buttonSize: Size(double.maxFinite, 45),
                    icon: null,
                    isElevated: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildHasntDataContainer() {
    return Container(
      decoration: BoxDecoration(
          color: Colours.workout_card_foreground_color,
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(
          Strings.empty,
          style: Styles.title_text_style,
        ),
      ),
    );
  }

  Container buildHasDataList() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colours.workout_card_foreground_color),
      padding: EdgeInsets.all(8),
      child: ListView.builder(
          itemCount: filteredExercises.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => addExercise(context, index),
              child: Card(
                  color: Colours.workout_card_background_color,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(
                            "lib/assets/images/workout_image.png",
                          ),
                          height: 70,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              truncateText(filteredExercises[index].title, 50),
                              style: Styles.add_exercise_text_style,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          }),
    );
  }

  void addExercise(BuildContext context, int index) {
    final newExercise = filteredExercises[index];
    Navigator.of(context).pop(newExercise);
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
      widget.exercises =
          ModalRoute.of(context)?.settings.arguments as Exercises;
    });
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + '...';
    }
  }
}
