part of 'made_workouts_bloc.dart';

sealed class MadeWorkoutsState extends Equatable {
  const MadeWorkoutsState();
  
  @override
  List<Object> get props => [];
}

final class MadeWorkoutsInitial extends MadeWorkoutsState {}
