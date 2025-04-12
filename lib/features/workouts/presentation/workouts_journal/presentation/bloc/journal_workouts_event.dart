// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'journal_workouts_bloc.dart';

sealed class JournalWorkoutsEvent extends Equatable {
  const JournalWorkoutsEvent();

  @override
  List<Object> get props => [];
}

class FetchJournalEvent extends JournalWorkoutsEvent {}

class AddJournalWorkoutEvent extends JournalWorkoutsEvent {
  WorkoutEntity journalWorkout;
  AddJournalWorkoutEvent({
    required this.journalWorkout,
  });
}

class DeleteJournalWorkoutEvent extends JournalWorkoutsEvent {
  int index;
  DeleteJournalWorkoutEvent({
    required this.index,
  });
}
