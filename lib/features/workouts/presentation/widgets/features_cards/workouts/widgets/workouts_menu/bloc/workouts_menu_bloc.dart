import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_card_on_list.dart';
import 'package:equatable/equatable.dart';
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
}
