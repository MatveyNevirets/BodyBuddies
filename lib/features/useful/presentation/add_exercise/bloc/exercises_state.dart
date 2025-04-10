// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'exercises_bloc.dart';

sealed class ExercisesState extends Equatable {
  const ExercisesState();

  @override
  List<Object> get props => [];
}

class LoadingState extends ExercisesState {}

class InitState extends ExercisesState {}

class SearchExericsesState extends ExercisesState {
  List<ExerciseOnListEntity> exercises;
  SearchExericsesState({
    required this.exercises,
  });
}
