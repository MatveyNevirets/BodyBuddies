import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'exercises_event.dart';
part 'exercises_state.dart';

class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  UsefulRepository usefulRepository;
  List<ExerciseOnListEntity> allExercises = [];
  List<ExerciseOnListEntity> filteredExercises = [];

  ExercisesBloc(this.usefulRepository) : super(InitState()) {
    on<InitializeEvent>(_initializeExercises);
    on<SearchEvent>(_searchExercises);
    on<AddYourExerciseEvent>(_addYourExercise);
  }

  Future<void> _initializeExercises(
      InitializeEvent event, Emitter<ExercisesState> emit) async {
    emit(LoadingState());
    try {
      final storage = AppDependsProvider.of(event.context).secureStorage;

      final jsonToken = await storage.read(dotenv.env['TOKEN_KEY']!);
      final mapToken = jsonDecode(jsonToken);
      final token = mapToken['access_token'];

      allExercises = await usefulRepository.fetchExercises(token);
      emit(SearchExericsesState(exercises: allExercises));
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }

  void _addYourExercise(
      AddYourExerciseEvent event, Emitter<ExercisesState> emit) {
    emit(LoadingState());
    final newExercise = event.exercise;

    if (newExercise != null) {
      allExercises.add(newExercise);
    }

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
