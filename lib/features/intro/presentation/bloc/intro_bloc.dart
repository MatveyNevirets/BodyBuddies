import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(IntroInitial()) {
    on<IntroEvent>(_initialIntoEventHandler);
  }

  Future<void> _initialIntoEventHandler(IntroEvent e, Emitter emit) async {
    return emit(IntroInitial());
  }
}
