import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/features/useful/presentation/add_exercise/bloc/exercises_bloc.dart';
import 'package:body_buddies/features/useful/presentation/add_exercise/presentation/add_exercise_screen.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExercisePage extends StatelessWidget {
  const AddExercisePage(
      {super.key, required this.usefulRepository, required this.secureStorage});

  final UsefulRepository usefulRepository;
  final SecureStorage secureStorage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ExercisesBloc(usefulRepository, secureStorage: secureStorage)
            ..add(InitializeEvent(context)),
      child: AddExerciseScreen(),
    );
  }
}
