import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/features/useful/bench_press_calculator/presentation/bloc/bench_press_calculator_bloc.dart';
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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                children: [
                  buildTextFields(weightController, repsController),
                  buildResults(),
                  const SizedBox(
                    height: 10,
                  ),
                  buildCalculateButton(context)
                ],
              )),
        ),
      ),
    );
  }

  void calculateResults(BuildContext context) {
    context.read<BenchPressCalculatorBloc>().add(CalculateEvent(
        double.parse(weightController.text), int.parse(repsController.text)));
  }

  BaseButton buildCalculateButton(BuildContext context) {
    return BaseButton(
      onClick: () => calculateResults(context),
      buttonText: Strings.calculate,
      icon: null,
      isElevated: true,
      backgroundColor: Colours.workoutCardForegroundColor,
      color: Colours.workout_card_background_color,
      buttonSize: const Size(double.maxFinite, 50),
      radius: 8,
    );
  }

  Card buildResults() {
    return Card(
      color: Colours.workoutCardForegroundColor,
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              BlocBuilder<BenchPressCalculatorBloc, BenchPressCalculatorState>(
            builder: (context, state) {
              return Column(
                children: [
                  Text("Формула Эпли ${state.epleysFormulaResult.toString()}"),
                  Text(
                      "Формула Мэтта Бжицки ${state.mattBrzyckisFormulaResult.toString()}"),
                  Text(
                      "Формула Лэндера ${state.landersFormulaResult.toString()}"),
                  Text(
                      "Формула О Коннор ${state.oConnersFormulaResult.toString()}"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Приблизительно ваш максимальный жим: ${state.averageResult.toString()}"),
                ],
              );
            },
            buildWhen: (prev, curr) =>
                !const ListEquality().equals(prev.props, curr.props),
          ),
        ),
      ),
    );
  }

  Padding buildTextFields(
      TextEditingController weightController, repsController) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colours.workout_card_background_color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
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
                        controller: weightController,
                        decoration: const InputDecoration(),
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
                        controller: repsController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
