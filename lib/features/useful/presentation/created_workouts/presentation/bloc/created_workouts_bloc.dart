import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:equatable/equatable.dart';

part 'created_workouts_event.dart';
part 'created_workouts_state.dart';

class CreatedWorkoutsBloc
    extends Bloc<CreatedWorkoutsEvent, CreatedWorkoutsState> {
  final UsefulRepository usefulRepository;
  final SecureStorage storage;

  CreatedWorkoutsBloc(this.usefulRepository, this.storage)
      : super(CreatedWorkoutsInitial()) {
    on<FetchWorkoutsEvent>(_fetchWorkouts);
  }

  Future<void> _fetchWorkouts(
      FetchWorkoutsEvent event, Emitter<CreatedWorkoutsState> emit) async {
    emit(LoadingState());
    try {
      final jsonToken = await storage.read(AppConsts.tokenKey);
      final mapToken = jsonDecode(jsonToken);
      final token = mapToken['access_token'];

      final workouts = await usefulRepository.fetchCreatedWorkouts(token);

      emit(FetchCreatedWorkoutsState(workouts: workouts));
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }
}
