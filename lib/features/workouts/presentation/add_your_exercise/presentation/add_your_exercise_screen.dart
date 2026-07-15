import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../core/strings/strings.dart';
import '../../../../../core/themes/themes.dart';

class AddYourExerciseScreen extends StatefulWidget {
  const AddYourExerciseScreen({
    super.key,
  });

  @override
  State<AddYourExerciseScreen> createState() => _AddYourExerciseScreenState();
}

class _AddYourExerciseScreenState extends State<AddYourExerciseScreen> {
  final titleController = TextEditingController();

  bool isTimerExercise = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 64,
            ),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: DarkTheme.surface,
              border: Border.all(
                color: DarkTheme.divider,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: DarkTheme.backgroundSecondary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Введите название своего упражнения",
                    style: DarkTheme.workout_text_style_background_24,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: DarkTheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: DarkTheme.divider,
                      ),
                    ),
                    child: TextField(
                      buildCounter: null,
                      controller: titleController,
                      cursorColor: DarkTheme.primary,
                      textAlign: TextAlign.start,
                      style: DarkTheme.body_text_style,
                      decoration: InputDecoration(
                        isDense: true,
                        hintStyle: DarkTheme.hint_text_style_create_exercise,
                        hintText: Strings.title,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      Text(
                        "По таймеру",
                        style: DarkTheme.workout_text_style_background_24,
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Checkbox(
                        checkColor: DarkTheme.background,
                        activeColor: DarkTheme.primary,
                        side: const BorderSide(
                          color: DarkTheme.divider,
                          width: 2,
                        ),
                        value: isTimerExercise,
                        onChanged: (newValue) => setState(() {
                          isTimerExercise = newValue!;
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  BaseButton(
                    onClick: () => tryToAddExercise(
                      context,
                      titleController.text.toString(),
                      isTimerExercise,
                    ),
                    buttonText: Strings.add,
                    backgroundColor: DarkTheme.primary,
                    color: DarkTheme.background,
                    buttonSize: const Size(
                      double.maxFinite,
                      45,
                    ),
                    radius: 14,
                    icon: null,
                    isElevated: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void tryToAddExercise(
    BuildContext context,
    String title,
    bool isTimerExercise,
  ) {
    if (titleController.text.isNotEmpty) {
      hasBeenAdd(
        context,
        title,
        isTimerExercise,
      );
    } else {
      showSnackBar(
        context,
        Strings.not_full_field_error,
      );
    }
  }

  void hasBeenAdd(
    BuildContext context,
    String title,
    bool isTimerExercise,
  ) {
    final newExercise = ExerciseOnListEntity(
      title: title,
      isExercise: !isTimerExercise,
    );

    Navigator.of(context).pop(newExercise);
  }
}
