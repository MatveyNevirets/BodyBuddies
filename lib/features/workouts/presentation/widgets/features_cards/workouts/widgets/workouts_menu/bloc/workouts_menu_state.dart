part of 'workouts_menu_bloc.dart';

@immutable
sealed class WorkoutsMenuState {
  FakeWorkoutsDatabase database;
  WorkoutsMenuState(this.database);
}

final class WorkoutsMenuInitial extends WorkoutsMenuState {
  WorkoutsMenuInitial(super.database);

}

class AddWorkoutState extends WorkoutsMenuState {
  AddWorkoutState(super.database);
}
