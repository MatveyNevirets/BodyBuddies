import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_exercise_state.dart';

class AddExerciseCubit extends Cubit<AddExerciseState> {
  AddExerciseCubit() : super(AddExerciseInitial());
}
