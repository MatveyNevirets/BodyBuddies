import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_your_exercise_state.dart';

class AddYourExerciseCubit extends Cubit<AddYourExerciseState> {
  AddYourExerciseCubit() : super(AddYourExerciseInitial());
}
