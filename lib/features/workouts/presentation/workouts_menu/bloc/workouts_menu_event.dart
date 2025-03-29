part of 'workouts_menu_bloc.dart';

@immutable
sealed class WorkoutsMenuEvent {
  final WorkoutsRepository workoutsRepository;
  const WorkoutsMenuEvent(this.workoutsRepository);
}

class AddWorkoutEvent extends WorkoutsMenuEvent {
  const AddWorkoutEvent(super.workoutsRepository);
}

class UpdateWorkoutEvent extends WorkoutsMenuEvent {
  const UpdateWorkoutEvent(super.workoutsRepository);
}

class RemoveWorkoutEvent extends WorkoutsMenuEvent {
  const RemoveWorkoutEvent(super.workoutsRepository);
}
