// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/cupertino.dart';

part 'workouts_menu_event.dart';

part 'workouts_menu_state.dart';

class WorkoutsMenuBloc extends Bloc<WorkoutsMenuEvent, WorkoutsMenuState> {
  WorkoutsRepository workoutsRepository;
  SecureStorage storage;

  WorkoutsMenuBloc(this.workoutsRepository, this.storage)
      : super(WorkoutsMenuInitial()) {
    on<UpdateWorkoutEvent>(_onUpdateCard);
    on<DeleteWorkoutEvent>(_onDeleteWorkout);
  }

  void _onUpdateCard(
      UpdateWorkoutEvent event, Emitter<WorkoutsMenuState> emit) async {
    emit(LoadingWorkoutState());
    try {
      final tokenJson = await storage.read(AppConsts.tokenKey);
      final tokenMap = jsonDecode(tokenJson);
      final token = tokenMap['access_token'];

      log(token);

      final workouts = await workoutsRepository.fetchAllWorkout(token);

      log(workouts.toString());

      emit(UpdateWorkoutState(workouts));
    } catch (e) {
      emit(UpdateWorkoutState(const []));
      throw Exception(
          "Server error on fetch workout in workouts menu. Error: $e");
    }
  }

  void _onDeleteWorkout(
      DeleteWorkoutEvent event, Emitter<WorkoutsMenuState> emit) async {
    try {
      emit(LoadingWorkoutState());

      final tokenJson = await storage.read(AppConsts.tokenKey);
      final tokenMap = jsonDecode(tokenJson);
      final token = tokenMap['access_token'];

      await workoutsRepository.deleteWorkout(event.index, token);

      final workouts = await workoutsRepository.fetchAllWorkout(token);

      emit(UpdateWorkoutState(workouts));
    } on Object catch (error, stack) {
      throw "Server error on fetch workout in workouts menu. Error: $error, StackTrace: $stack";
    }
  }
}
