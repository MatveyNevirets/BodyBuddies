part of 'run_workout_bloc.dart';

@immutable
sealed class RunWorkoutState {}

final class RunWorkoutInitial extends RunWorkoutState {}

class StartWorkoutState extends RunWorkoutState {}

class WorkoutInProcess extends RunWorkoutState {}

class RestWorkoutProcess extends RunWorkoutState {}
