part of 'workouts_menu_bloc.dart';

@immutable
sealed class WorkoutsMenuEvent {
}

class AddWorkoutEvent extends WorkoutsMenuEvent {
  final FakeWorkoutsDatabase database;
  AddWorkoutEvent(this.database);
}

class UpdateWorkoutEvent extends WorkoutsMenuEvent {
  final FakeWorkoutsDatabase database;
  UpdateWorkoutEvent(this.database);
}

class RemoveWorkoutEvent extends WorkoutsMenuEvent {
  final FakeWorkoutsDatabase database;
  RemoveWorkoutEvent(this.database);
}