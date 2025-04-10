part of 'bench_press_calculator_bloc.dart';

sealed class BenchPressCalculatorState extends Equatable {
  BenchPressCalculatorState(
      {required this.epleysFormulaResult,
      required this.mattBrzyckisFormulaResult,
      required this.landersFormulaResult,
      required this.oConnersFormulaResult,
      required this.averageResult});

  double epleysFormulaResult;
  double mattBrzyckisFormulaResult;
  double landersFormulaResult;
  double oConnersFormulaResult;

  double averageResult;

  @override
  List<Object> get props => [
        epleysFormulaResult,
        mattBrzyckisFormulaResult,
        landersFormulaResult,
        oConnersFormulaResult,
        averageResult
      ];
}

final class BenchPressCalculatorInitial extends BenchPressCalculatorState {
  BenchPressCalculatorInitial(
      {required super.epleysFormulaResult,
      required super.mattBrzyckisFormulaResult,
      required super.landersFormulaResult,
      required super.oConnersFormulaResult,
      required super.averageResult});
}

class ResultsBenchPressState extends BenchPressCalculatorState {
  ResultsBenchPressState(
      {required super.epleysFormulaResult,
      required super.mattBrzyckisFormulaResult,
      required super.landersFormulaResult,
      required super.oConnersFormulaResult,
      required super.averageResult});
}
