// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'workouts_menu_bloc.dart';

@immutable
sealed class WorkoutsMenuEvent {
  BuildContext context;
  WorkoutsMenuEvent({
    required this.context,
  });
}

class UpdateWorkoutEvent extends WorkoutsMenuEvent {
  UpdateWorkoutEvent({required super.context});
}

class DeleteWorkoutEvent extends WorkoutsMenuEvent {
  int index;
  DeleteWorkoutEvent({required super.context, required this.index});
}
