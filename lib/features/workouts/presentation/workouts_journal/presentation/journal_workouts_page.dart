import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/bloc/journal_workouts_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/workouts_journal_screen.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JournalWorkoutsPage extends StatelessWidget {
  const JournalWorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final depends = AppDependsProvider.of(context);

    return BlocProvider(
      create: (BuildContext context) =>
          JournalWorkoutsBloc(depends.workoutsRepository, depends.secureStorage)
            ..add(FetchJournalEvent()),
      child: const WorkoutsJournalScreen(),
    );
  }
}
