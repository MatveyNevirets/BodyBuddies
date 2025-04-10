import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/useful/presentation/bench_press_calculator/presentation/bloc/bench_press_calculator_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BenchPressCalculatorScreen extends StatelessWidget {
  BenchPressCalculatorScreen({super.key});

  final weightController = TextEditingController();
  final repsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBarWidget(
        appbarTitle: Strings.bench_press_calculator_appbar,
        context: context,
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      buildTextFields(
                          weightController, repsController, context),
                      buildResults(),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }

  void calculateResults(BuildContext context) {
    context.read<BenchPressCalculatorBloc>().add(CalculateEvent(
        double.parse(weightController.text), int.parse(repsController.text)));
  }

  Padding buildCalculateButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: BaseButton(
        onClick: () => calculateResults(context),
        buttonText: Strings.calculate,
        icon: null,
        isElevated: true,
        backgroundColor: Colours.workoutCardForegroundColor,
        color: Colours.workout_card_background_color,
        buttonSize: const Size(double.maxFinite, 50),
        radius: 8,
      ),
    );
  }

  Card buildResults() {
    return Card(
      color: Colours.workout_card_background_color,
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colours.workoutCardForegroundColor,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<BenchPressCalculatorBloc,
                  BenchPressCalculatorState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Text(
                        "Формула Эпли",
                        style: Styles.reverse_rest_text_style,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.maxFinite,
                        child: Card(
                          color: Colours.workout_card_background_color,
                          child: Center(
                            child: Text(
                              state.epleysFormulaResult.toString(),
                              style: Styles.add_exercise_text_style,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Формула Мэтта Бжицки",
                        style: Styles.reverse_rest_text_style,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.maxFinite,
                        child: Card(
                          color: Colours.workout_card_background_color,
                          child: Center(
                            child: Text(
                              state.mattBrzyckisFormulaResult.toString(),
                              style: Styles.add_exercise_text_style,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Формула Лэндера",
                        style: Styles.reverse_rest_text_style,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.maxFinite,
                        child: Card(
                          color: Colours.workout_card_background_color,
                          child: Center(
                            child: Text(
                              state.landersFormulaResult.toString(),
                              style: Styles.add_exercise_text_style,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Формула О Коннор",
                        style: Styles.reverse_rest_text_style,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.maxFinite,
                        child: Card(
                          color: Colours.workout_card_background_color,
                          child: Center(
                            child: Text(
                              state.oConnersFormulaResult.toString(),
                              style: Styles.add_exercise_text_style,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Приблизительно ваш максимальный жим:",
                        style: Styles.reverse_rest_text_style,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.maxFinite,
                        child: Card(
                          color: Colours.workout_card_background_color,
                          child: Center(
                            child: Text(
                              state.averageResult.toString(),
                              style: Styles.add_exercise_text_style,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                buildWhen: (prev, curr) =>
                    !const ListEquality().equals(prev.props, curr.props),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildTextFields(TextEditingController weightController,
      repsController, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colours.workout_card_background_color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                color: Colours.workoutCardForegroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        Strings.weight,
                        style: Styles.reverse_rest_text_style,
                      ),
                      Card(
                        color: Colours.workout_card_background_color,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: Styles.add_exercise_text_style,
                            cursorColor: Colours.workoutCardForegroundColor,
                            keyboardType: TextInputType.number,
                            controller: weightController,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Colours.workoutCardForegroundColor,
                                        width: 3)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colours.grey_text_color,
                                        width: 3))),
                          ),
                        ),
                      ),
                      Text(
                        Strings.reps,
                        style: Styles.reverse_rest_text_style,
                      ),
                      Card(
                        color: Colours.workout_card_background_color,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: Styles.add_exercise_text_style,
                            cursorColor: Colours.workoutCardForegroundColor,
                            controller: repsController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Colours.workoutCardForegroundColor,
                                        width: 3)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colours.grey_text_color,
                                        width: 3))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildCalculateButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
