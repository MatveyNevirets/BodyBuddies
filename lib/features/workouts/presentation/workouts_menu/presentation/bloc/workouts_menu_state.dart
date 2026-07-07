// ignore_for_file: must_be_immutable

part of 'workouts_menu_bloc.dart';

@immutable
sealed class WorkoutsMenuState {}

final class WorkoutsMenuInitial extends WorkoutsMenuState {
  WorkoutsMenuInitial();
}

class UpdateWorkoutState extends WorkoutsMenuState {
  List<WorkoutEntity>? workouts;
  UpdateWorkoutState(this.workouts);
}

class LoadingWorkoutState extends WorkoutsMenuState {}
