part of 'bench_press_calculator_bloc.dart';

sealed class BenchPressCalculatorEvent extends Equatable {
  BenchPressCalculatorEvent(this.weight, this.reps);

  double weight;
  int reps;

  @override
  List<Object> get props => [];
}

class CalculateEvent extends BenchPressCalculatorEvent {
  CalculateEvent(super.weight, super.reps);
}
