// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'created_workouts_bloc.dart';

sealed class CreatedWorkoutsEvent extends Equatable {
  const CreatedWorkoutsEvent();

  @override
  List<Object> get props => [];
}

class FetchWorkoutsEvent extends CreatedWorkoutsEvent {}

class AddCreatedWorkoutEvent extends CreatedWorkoutsEvent {
  int index;
  AddCreatedWorkoutEvent({
    required this.index,
  });
}
