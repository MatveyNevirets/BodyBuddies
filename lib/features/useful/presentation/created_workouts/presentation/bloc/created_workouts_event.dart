part of 'created_workouts_bloc.dart';

sealed class CreatedWorkoutsEvent extends Equatable {
  const CreatedWorkoutsEvent();

  @override
  List<Object> get props => [];
}

class FetchWorkoutsEvent extends CreatedWorkoutsEvent {}
