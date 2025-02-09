import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:meta/meta.dart';

import '../../domain/fake_workouts_database.dart';

part 'workouts_journal_state.dart';

class WorkoutsJournalCubit extends Cubit<List<WorkoutEntity>> {
  FakeWorkoutsDatabase fakeWorkoutsDatabase;

  WorkoutsJournalCubit(this.fakeWorkoutsDatabase)
      : super(fakeWorkoutsDatabase.journalSavedWorkouts);


}
