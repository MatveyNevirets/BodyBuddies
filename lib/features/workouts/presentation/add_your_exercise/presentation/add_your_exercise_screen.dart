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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: DarkTheme.background,
      body: Stack(
        children: [
          // Геометрические фигуры – напряжение и движение (фон)
          Positioned(
            top: -screenHeight * 0.12,
            right: -screenWidth * 0.25,
            child: Transform.rotate(
              angle: 0.35,
              child: Container(
                width: screenWidth * 1.1,
                height: screenWidth * 1.1,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: DarkTheme.primary.withOpacity(0.04),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -screenHeight * 0.06,
            left: -screenWidth * 0.35,
            child: Transform.rotate(
              angle: -0.25,
              child: Container(
                width: screenWidth * 1.3,
                height: 6,
                decoration: BoxDecoration(
                  color: DarkTheme.primary.withOpacity(0.05),
                ),
              ),
            ),
          ),

          // Основной контент
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: screenHeight * 0.08,
                  bottom: bottomInset + 32,
                ),
                child: Container(
                  width: screenWidth * 0.9 > 400 ? 400 : screenWidth * 0.9,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: DarkTheme.surface,
                    border: Border.all(
                      color: DarkTheme.divider,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Заголовок
                      Text(
                        "Введите название своего упражнения",
                        style: DarkTheme.workout_text_style_background_24,
                      ),
                      const SizedBox(height: 24),

                      // Поле ввода
                      Container(
                        decoration: BoxDecoration(
                          color: DarkTheme.backgroundSecondary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: DarkTheme.divider,
                          ),
                        ),
                        child: TextField(
                          controller: titleController,
                          cursorColor: DarkTheme.primary,
                          style: DarkTheme.body_text_style,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                            hintText: Strings.title,
                            hintStyle:
                                DarkTheme.hint_text_style_create_exercise,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: DarkTheme.primary,
                                width: 1,
                              ),
                            ),
                            filled: true,
                            fillColor: DarkTheme.backgroundSecondary,
                          ),
                          buildCounter: null,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Чекбокс "По таймеру"
                      Row(
                        children: [
                          Text(
                            "По таймеру",
                            style: DarkTheme.workout_text_style_background_24,
                          ),
                          const Spacer(),
                          Checkbox(
                            value: isTimerExercise,
                            onChanged: (newValue) => setState(() {
                              isTimerExercise = newValue!;
                            }),
                            checkColor: DarkTheme.background,
                            activeColor: DarkTheme.primary,
                            side: const BorderSide(
                              color: DarkTheme.divider,
                              width: 2,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Кнопка "Добавить"
                      BaseButton(
                        onClick: () => tryToAddExercise(
                          context,
                          titleController.text.toString(),
                          isTimerExercise,
                        ),
                        buttonText: Strings.add,
                        backgroundColor: DarkTheme.primary,
                        color: DarkTheme.background,
                        buttonSize: const Size(double.maxFinite, 48),
                        radius: 14,
                        icon: null,
                        isElevated: true,
                      ),
                    ],
                  ),
                ),
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
