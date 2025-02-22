import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:meta/meta.dart';

part 'workouts_menu_event.dart';

part 'workouts_menu_state.dart';

class WorkoutsMenuBloc extends Bloc<WorkoutsMenuEvent, WorkoutsMenuState> {
  FakeWorkoutsDatabase database;

  WorkoutsMenuBloc(this.database) : super(WorkoutsMenuInitial(database)) {
    on<AddWorkoutEvent>(onAddCard);
  }

  void onAddCard(AddWorkoutEvent event, Emitter<WorkoutsMenuState> emit) {
    emit(AddWorkoutState(event.database));
  }

  void onRemoveCard(RemoveWorkoutEvent event, Emitter<WorkoutsMenuState> emit) {
    emit(AddWorkoutState(event.database));
  }

  void onUpdateCard(UpdateWorkoutEvent event, Emitter<WorkoutsMenuState> emit) {
    emit(UpdateWorkoutState(event.database));
  }
}
