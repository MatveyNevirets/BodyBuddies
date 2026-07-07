import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/bloc/journal_workouts_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/workouts_journal_screen.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JournalWorkoutsPage extends StatelessWidget {
  const JournalWorkoutsPage(
      {super.key,
      required this.workoutsRepository,
      required this.secureStorage,
      required this.isConnection});

  final WorkoutsRepository workoutsRepository;
  final SecureStorage secureStorage;
  final bool isConnection;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          JournalWorkoutsBloc(workoutsRepository, secureStorage)
            ..add(FetchJournalEvent()),
      child: WorkoutsJournalScreen(
        isConnection: isConnection,
      ),
    );
  }
}
