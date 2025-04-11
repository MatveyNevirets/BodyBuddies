// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'created_workouts_bloc.dart';

sealed class CreatedWorkoutsState extends Equatable {
  const CreatedWorkoutsState();

  @override
  List<Object> get props => [];
}

final class CreatedWorkoutsInitial extends CreatedWorkoutsState {}

class FetchCreatedWorkoutsState extends CreatedWorkoutsState {
  List<WorkoutEntity> workouts;
  FetchCreatedWorkoutsState({
    required this.workouts,
  });
}

class CreatedWorkoutAddedState extends CreatedWorkoutsState {
  String message;
  CreatedWorkoutAddedState({
    required this.message,
  });
}

class LoadingState extends CreatedWorkoutsState {}
