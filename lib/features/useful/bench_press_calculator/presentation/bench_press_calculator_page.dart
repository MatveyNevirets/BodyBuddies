import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/features/useful/bench_press_calculator/presentation/bench_press_calculator_screen.dart';
import 'package:body_buddies/features/useful/bench_press_calculator/presentation/bloc/bench_press_calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BenchPressCalculatorPage extends StatelessWidget {
  BenchPressCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BenchPressCalculatorBloc(),
      child: BenchPressCalculatorScreen(),
    );
  }
}
