import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bench_press_calculator_event.dart';
part 'bench_press_calculator_state.dart';

class BenchPressCalculatorBloc
    extends Bloc<BenchPressCalculatorEvent, BenchPressCalculatorState> {
  BenchPressCalculatorBloc()
      : super(BenchPressCalculatorInitial(
            epleysFormulaResult: 0,
            mattBrzyckisFormulaResult: 0,
            landersFormulaResult: 0,
            oConnersFormulaResult: 0,
            averageResult: 0)) {
    on<CalculateEvent>(calculate);
  }

  void calculate(
      CalculateEvent event, Emitter<BenchPressCalculatorState> emit) {
    emit(ResultsBenchPressState(
        epleysFormulaResult: calculateOnEpley(event.weight, event.reps),
        mattBrzyckisFormulaResult:
            calculateOnMattBrzyckis(event.weight, event.reps),
        landersFormulaResult: calculateOnLanders(event.weight, event.reps),
        oConnersFormulaResult: calculateOnOConner(event.weight, event.reps),
        averageResult: calculateAverageResult(event.weight, event.reps)));
  }

  double calculateOnEpley(double weight, int reps) {
    double result = (weight * reps) / 30 + weight;
    return _truncateResult(result);
  }

  double calculateOnMattBrzyckis(double weight, int reps) {
    double result = weight * (36 / (37 - reps));
    return _truncateResult(result);
  }

  double calculateOnLanders(double weight, int reps) {
    double result = (100 * weight) / (101.3 - 2.67123 * reps);
    result.truncateToDouble();
    return _truncateResult(result);
  }

  double calculateOnOConner(double weight, int reps) {
    double result = weight * (1 + 0.025 * reps);
    result.roundToDouble();
    return _truncateResult(result);
  }

  double calculateAverageResult(double weight, int reps) {
    double result = (calculateOnEpley(weight, reps) +
            calculateOnMattBrzyckis(weight, reps) +
            calculateOnMattBrzyckis(weight, reps) +
            calculateOnOConner(weight, reps)) /
        4;
    return _truncateResult(result);
  }

  double _truncateResult(double oldResult) {
    double newResult = double.parse(oldResult.toStringAsFixed(1));
    return newResult;
  }
}
