part of 'exercises_bloc.dart';

sealed class ExercisesEvent extends Equatable {
  BuildContext context;
  ExercisesEvent(this.context);

  @override
  List<Object> get props => [];
}

class InitializeEvent extends ExercisesEvent {
  InitializeEvent(super.context);
}

class AddYourExerciseEvent extends ExercisesEvent {
  ExerciseOnListEntity? exercise;
  AddYourExerciseEvent(super.context, this.exercise);
}

class SearchEvent extends ExercisesEvent {
  String query;
  SearchEvent(super.context, this.query);
}
