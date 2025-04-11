// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'workouts_menu_bloc.dart';

@immutable
sealed class WorkoutsMenuEvent {}

class UpdateWorkoutEvent extends WorkoutsMenuEvent {}

class DeleteWorkoutEvent extends WorkoutsMenuEvent {
  int index;
  DeleteWorkoutEvent({required this.index});
}
