import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'made_workouts_event.dart';
part 'made_workouts_state.dart';

class MadeWorkoutsBloc extends Bloc<MadeWorkoutsEvent, MadeWorkoutsState> {
  MadeWorkoutsBloc() : super(MadeWorkoutsInitial()) {
    on<MadeWorkoutsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
