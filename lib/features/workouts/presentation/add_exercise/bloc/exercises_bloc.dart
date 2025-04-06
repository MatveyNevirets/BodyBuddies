import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_on_list_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'exercises_event.dart';
part 'exercises_state.dart';

class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  WorkoutsRepository workoutsRepository;
  List<ExerciseOnListEntity> allExercises = [];
  List<ExerciseOnListEntity> filteredExercises = [];

  ExercisesBloc(this.workoutsRepository) : super(InitState()) {
    on<InitializeEvent>(_initializeExercises);
    on<SearchEvent>(_searchExercises);
  }

  Future<void> _initializeExercises(
      InitializeEvent event, Emitter<ExercisesState> emit) async {
    emit(LoadingState());
    allExercises =
        await workoutsRepository.fetchAllExercisesToAddList(event.context);
    emit(SearchExericsesState(exercises: allExercises));
  }

  void _searchExercises(SearchEvent event, Emitter<ExercisesState> emit) {
    emit(LoadingState());
    if (event.query.isNotEmpty) {
      filteredExercises = allExercises.where((ExerciseOnListEntity entity) {
        return entity.title
            .toLowerCase()
            .replaceAll(" ", "")
            .contains(event.query);
      }).toList();
    } else if (event.query.isEmpty) {
      filteredExercises = allExercises;
    }
    emit(SearchExericsesState(exercises: filteredExercises));
  }
}
