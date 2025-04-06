import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:flutter/cupertino.dart';

part 'workouts_menu_event.dart';

part 'workouts_menu_state.dart';

class WorkoutsMenuBloc extends Bloc<WorkoutsMenuEvent, WorkoutsMenuState> {
  WorkoutsRepository workoutsRepository;

  WorkoutsMenuBloc(this.workoutsRepository) : super(WorkoutsMenuInitial()) {
    on<UpdateWorkoutEvent>(_onUpdateCard);
    on<DeleteWorkoutEvent>(_onDeleteWorkout);
  }

  void _onUpdateCard(
      UpdateWorkoutEvent event, Emitter<WorkoutsMenuState> emit) async {
    emit(LoadingWorkoutState());
    try {
      final workouts = await workoutsRepository.fetchAllWorkout(event.context);
      emit(UpdateWorkoutState(workouts));
    } catch (e) {
      throw Exception(
          "Server error on fetch workout in workouts menu. Error: $e");
    }
  }

  void _onDeleteWorkout(
      DeleteWorkoutEvent event, Emitter<WorkoutsMenuState> emit) async {
    emit(LoadingWorkoutState());
    try {
      await workoutsRepository.deleteWorkout(event.index, event.context);
    } catch (e) {
      throw Exception(
          "Server error on fetch workout in workouts menu. Error: $e");
    }

    final workouts = await workoutsRepository.fetchAllWorkout(event.context);
    emit(UpdateWorkoutState(workouts));
  }
}
