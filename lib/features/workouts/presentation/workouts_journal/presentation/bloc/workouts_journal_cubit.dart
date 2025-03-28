import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/domain/entity/workout_entity.dart';
import 'package:meta/meta.dart';

import '../../../workouts_menu/domain/fake_workouts_database.dart';

part 'workouts_journal_state.dart';

class WorkoutsJournalCubit extends Cubit<List<WorkoutEntity>> {
  FakeWorkoutsDatabase fakeWorkoutsDatabase;

  WorkoutsJournalCubit(this.fakeWorkoutsDatabase)
      : super(fakeWorkoutsDatabase.journalSavedWorkouts);

  void addSavedWorkout(WorkoutEntity savedWorkout) {
    final List<WorkoutEntity> updatedList = List.from(state)..add(savedWorkout);
    fakeWorkoutsDatabase.journalSavedWorkouts = updatedList;
    emit(updatedList);
  }

  void removeSavedWorkout(int index) {
    final List<WorkoutEntity> updatedList = List.from(state)..removeAt(index);
    fakeWorkoutsDatabase.journalSavedWorkouts = updatedList;
    emit(updatedList);
  }
}
