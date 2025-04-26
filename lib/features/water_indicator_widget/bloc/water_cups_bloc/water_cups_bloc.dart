import 'package:bloc/bloc.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'water_cups_event.dart';
part 'water_cups_state.dart';

class WaterCupsBloc extends Bloc<WaterCupsEvent, WaterCupsState> {
  final int index;

  WaterCupsBloc(this.index) : super(WaterCupsInitial()) {
    on<InitCupEvent>(_initializeHandler);
    on<ActivatingCupEvent>(_activateEventHandler);
    on<DeactivatingCupEvent>(_deactivateEventHandler);
  }

  Future<void> _initializeHandler(InitCupEvent e, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();
    final state = prefs.getBool("cup$index");

    final lastSavedDay = prefs.getString(AppConsts.dayConst);
    final currentDay =
        "${DateTime.now().day}:${DateTime.now().month}:${DateTime.now().year}";

    if (lastSavedDay == null || lastSavedDay == currentDay) {
      if (state == true) {
        emit(ActivatedCupState());
      } else {
        emit(DeactivatedCupState());
      }
    } else {
      emit(DeactivatedCupState());
    }

    await prefs.setString(AppConsts.dayConst, currentDay);
  }

  Future<void> _activateEventHandler(WaterCupsEvent e, Emitter emit) async {
    emit(ActivatedCupState());
  }

  Future<void> _deactivateEventHandler(WaterCupsEvent e, Emitter emit) async {
    emit(DeactivatedCupState());
  }
}
