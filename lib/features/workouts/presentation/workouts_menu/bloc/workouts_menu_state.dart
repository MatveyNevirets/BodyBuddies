// ignore_for_file: must_be_immutable

part of 'workouts_menu_bloc.dart';

@immutable
sealed class WorkoutsMenuState {
  WorkoutsRepository workoutsRepository;
  WorkoutsMenuState(this.workoutsRepository);
}

final class WorkoutsMenuInitial extends WorkoutsMenuState {
  WorkoutsMenuInitial(super.workoutsRepository);
}

class AddWorkoutState extends WorkoutsMenuState {
  AddWorkoutState(super.workoutsRepository);
}

class UpdateWorkoutState extends WorkoutsMenuState {
  UpdateWorkoutState(super.workoutsRepository);
}
