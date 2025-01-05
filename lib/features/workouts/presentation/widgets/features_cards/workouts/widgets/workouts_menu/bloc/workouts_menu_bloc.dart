import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'workouts_menu_event.dart';
part 'workouts_menu_state.dart';

class WorkoutsMenuBloc extends Bloc<WorkoutsMenuEvent, WorkoutsMenuState> {
  WorkoutsMenuBloc() : super(WorkoutsMenuInitial()) {
    on<WorkoutsMenuEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
