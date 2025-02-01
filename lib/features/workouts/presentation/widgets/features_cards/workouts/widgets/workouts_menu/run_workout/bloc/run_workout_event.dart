part of 'run_workout_bloc.dart';

@immutable
sealed class RunWorkoutEvent {}


class ExerciseRunEvent extends RunWorkoutEvent {}

class ExerciseRestEvent extends RunWorkoutEvent {}