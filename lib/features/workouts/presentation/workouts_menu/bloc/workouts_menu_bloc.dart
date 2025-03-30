import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:meta/meta.dart';

part 'workouts_menu_event.dart';

part 'workouts_menu_state.dart';

class WorkoutsMenuBloc extends Bloc<WorkoutsMenuEvent, WorkoutsMenuState> {
  WorkoutsRepository workoutsRepository;

  WorkoutsMenuBloc(this.workoutsRepository)
      : super(WorkoutsMenuInitial(workoutsRepository)) {
    on<AddWorkoutEvent>(onAddCard);
  }

  void onAddCard(AddWorkoutEvent event, Emitter<WorkoutsMenuState> emit) {
    emit(AddWorkoutState(event.workoutsRepository));
  }

  void onRemoveCard(RemoveWorkoutEvent event, Emitter<WorkoutsMenuState> emit) {
    emit(AddWorkoutState(event.workoutsRepository));
  }

  void onUpdateCard(UpdateWorkoutEvent event, Emitter<WorkoutsMenuState> emit) {
    emit(UpdateWorkoutState(event.workoutsRepository));
  }
}
