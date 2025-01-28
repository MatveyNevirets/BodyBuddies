import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_exercise_settings_event.dart';
part 'change_exercise_settings_state.dart';

class ChangeExerciseSettingsBloc extends Bloc<ChangeExerciseSettingsEvent, ChangeExerciseSettingsState> {
  ChangeExerciseSettingsBloc() : super(ChangeExerciseSettingsInitial()) {
    on<ChangeExerciseSettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
