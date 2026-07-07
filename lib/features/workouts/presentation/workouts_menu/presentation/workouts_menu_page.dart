import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/presentation/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/presentation/workouts_menu_screen.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsMenuPage extends StatelessWidget {
  const WorkoutsMenuPage(
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
          WorkoutsMenuBloc(workoutsRepository, secureStorage)
            ..add(UpdateWorkoutEvent()),
      child: WorkoutsMenuScreen(
        isConnection: isConnection,
        secureStorage: secureStorage,
        workoutsRepository: workoutsRepository,
      ),
    );
  }
}
