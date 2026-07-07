// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'journal_workouts_bloc.dart';

sealed class JournalWorkoutsState extends Equatable {
  const JournalWorkoutsState();

  @override
  List<Object> get props => [];
}

final class JournalWorkoutsInitial extends JournalWorkoutsState {}

class LoadingState extends JournalWorkoutsState {}

class FetchJournalState extends JournalWorkoutsState {
  List<WorkoutEntity>? journalWorkouts;
  FetchJournalState({
    required this.journalWorkouts,
  });
}
