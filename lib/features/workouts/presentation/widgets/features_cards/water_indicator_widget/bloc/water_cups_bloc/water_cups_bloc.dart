import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'water_cups_event.dart';
part 'water_cups_state.dart';

class WaterCupsBloc extends Bloc<WaterCupsEvent, WaterCupsState> {
  WaterCupsBloc() : super(WaterCupsInitial()) {
    on<WaterCupsEvent>(_initializeHandler);

    on<ActivatingCupEvent>(_activateEventHandler);

    on<DeactivatingCupEvent>(_deactivateEventHandler);
  }

  Future<void> _initializeHandler(WaterCupsEvent e, Emitter emit) async {
    emit(WaterCupsInitial());
  }

  Future<void> _activateEventHandler(WaterCupsEvent e, Emitter emit) async {
    emit(ActivatedCupState());
  }

  Future<void> _deactivateEventHandler(WaterCupsEvent e, Emitter emit) async {
    emit(DeactivatedCupState());
  }
}
