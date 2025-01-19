import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_exercise_event.dart';
part 'add_exercise_state.dart';

class AddExerciseBloc extends Bloc<AddExerciseEvent, AddExerciseState> {
  AddExerciseBloc() : super(AddExerciseInitial()) {
    on<AddExerciseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
