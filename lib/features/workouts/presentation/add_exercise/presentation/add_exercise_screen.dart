// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:async';

import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/workouts/presentation/add_exercise/bloc/exercises_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/strings/strings.dart';
import '../../../../../core/themes/themes.dart';

class AddExerciseScreen extends StatelessWidget {
  final searchTextFieldController = TextEditingController();

  AddExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void searchExercises() {
      String query =
          searchTextFieldController.text.toLowerCase().replaceAll(" ", "");

      context.read<ExercisesBloc>().add(
            SearchEvent(context, query),
          );
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: DarkTheme.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: DarkTheme.divider,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: DarkTheme.backgroundSecondary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: DarkTheme.divider,
                  ),
                ),
                child: TextField(
                  controller: searchTextFieldController,
                  cursorColor: DarkTheme.primary,
                  textAlign: TextAlign.start,
                  style: DarkTheme.body_text_style,
                  decoration: InputDecoration(
                    isDense: true,
                    hintStyle: DarkTheme.hint_text_style_create_workout,
                    hintText: Strings.search,
                    border: InputBorder.none,
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
                buttonText: Strings.add_yourself,
                backgroundColor: DarkTheme.primary,
                color: DarkTheme.background,
                radius: 14,
                buttonSize: const Size(
                  double.maxFinite,
                  45,
                ),
                icon: null,
                isElevated: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildExercisesListView(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: DarkTheme.backgroundSecondary,
          border: Border.all(
            color: DarkTheme.divider,
          ),
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
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      decoration: BoxDecoration(
                        color: DarkTheme.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: DarkTheme.divider,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const Image(
                              image: AssetImage(
                                "assets/images/workout_image.png",
                              ),
                              height: 70,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  truncateText(
                                    state.exercises[index].title,
                                    50,
                                  ),
                                  style: DarkTheme.add_exercise_text_style,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const LoadingScreen();
            }
          },
        ),
      ),
    );
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
