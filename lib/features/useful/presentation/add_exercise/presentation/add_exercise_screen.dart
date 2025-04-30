// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:async';

import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/useful/presentation/add_exercise/bloc/exercises_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/strings/strings.dart';
import '../../../../../core/styles/styles.dart';

class AddExerciseScreen extends StatelessWidget {
  final searchTextFieldController = TextEditingController();

  AddExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void searchExercises() {
      String query =
          searchTextFieldController.text.toLowerCase().replaceAll(" ", "");
      context.read<ExercisesBloc>().add(SearchEvent(context, query));
    }

    searchTextFieldController.addListener(searchExercises);

    Future<void> addYourExercise(BuildContext context) async {
      final createdExercise = await Navigator.of(context).pushNamed(
              "/workouts_menu/create_workout/add_exercise/add_your_exercise/")
          as ExerciseOnListEntity?;

      context
          .read<ExercisesBloc>()
          .add(AddYourExerciseEvent(context, createdExercise));
    }

    return Scaffold(
      appBar: createAppBarWidget(
          appbarTitle: Strings.change_exercise, context: context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colours.workout_card_background_color,
          elevation: 100,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
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
                const SizedBox(
                  height: 16,
                ),
                buildExercisesListView(context),
                const SizedBox(
                  height: 16,
                ),
                BaseButton(
                    onClick: () async => await addYourExercise(context),
                    // onClick: () async => await addYourExercise(context),
                    buttonText: Strings.add_yourself,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    color: Colours.workout_card_background_color,
                    radius: 8,
                    buttonSize: const Size(double.maxFinite, 45),
                    icon: null,
                    isElevated: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildExercisesListView(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<ExercisesBloc, ExercisesState>(
        builder: (context, state) {
          if (state is SearchExericsesState) {
            return ListView.builder(
              itemCount: state.exercises.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => addExercise(context, index, state),
                  child: Card(
                      color: Colours.workout_card_background_color,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            const Image(
                              image: AssetImage(
                                "lib/assets/images/workout_image.png",
                              ),
                              height: 70,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  truncateText(
                                      state.exercises[index].title, 50),
                                  style: Styles.add_exercise_text_style,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                );
              },
            );
          } else {
            return const LoadingScreen();
          }
        },
      ),
    ));
  }

  void addExercise(
      BuildContext context, int index, SearchExericsesState state) {
    final newExercise = state.exercises[index];
    Navigator.of(context).pop(newExercise);
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}
