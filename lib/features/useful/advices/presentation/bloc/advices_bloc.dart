import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'advices_event.dart';
part 'advices_state.dart';

class AdvicesBloc extends Bloc<AdvicesEvent, AdvicesState> {
  AdvicesBloc() : super(AdvicesInitial()) {
    return;
  }
}
