import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'journal_workouts_event.dart';
part 'journal_workouts_state.dart';

class JournalWorkoutsBloc
    extends Bloc<JournalWorkoutsEvent, JournalWorkoutsState> {
  WorkoutsRepository workoutsRepository;
  SecureStorage storage;

  late List<WorkoutEntity>? journalWorkouts;

  JournalWorkoutsBloc(this.workoutsRepository, this.storage)
      : super(JournalWorkoutsInitial()) {
    on<FetchJournalEvent>(_fetchJournal);
    on<AddJournalWorkoutEvent>(_addJournalWorkout);
    on<DeleteJournalWorkoutEvent>(_deleteJournalWorkout);
  }

  Future<void> _deleteJournalWorkout(DeleteJournalWorkoutEvent event,
      Emitter<JournalWorkoutsState> emit) async {
    emit(LoadingState());

    try {
      final jsonToken = await storage.read(dotenv.env['TOKEN_KEY']!);
      final mapToken = jsonDecode(jsonToken);
      final token = mapToken['access_token'];

      if (journalWorkouts != null) {
        await workoutsRepository.deleteJournalWorkout(
            journalWorkouts![event.index], token);
      }

      journalWorkouts = await workoutsRepository.fetchJournalWorkouts(token);

      emit(FetchJournalState(journalWorkouts: journalWorkouts));
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }

  Future<void> _addJournalWorkout(
      AddJournalWorkoutEvent event, Emitter<JournalWorkoutsState> emit) async {
    emit(LoadingState());

    try {
      final jsonToken = await storage.read(dotenv.env['TOKEN_KEY']!);
      final mapToken = jsonDecode(jsonToken);
      final token = mapToken['access_token'];

      await workoutsRepository.addJournalWorkout(event.journalWorkout, token);

      emit(FetchJournalState(journalWorkouts: journalWorkouts));
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }

  Future<void> _fetchJournal(
      FetchJournalEvent event, Emitter<JournalWorkoutsState> emit) async {
    emit(LoadingState());
    try {
      final jsonToken = await storage.read(dotenv.env['TOKEN_KEY']!);
      final mapToken = jsonDecode(jsonToken);
      final token = mapToken['access_token'];

      journalWorkouts = await workoutsRepository.fetchJournalWorkouts(token);

      emit(FetchJournalState(journalWorkouts: journalWorkouts));
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }
}
