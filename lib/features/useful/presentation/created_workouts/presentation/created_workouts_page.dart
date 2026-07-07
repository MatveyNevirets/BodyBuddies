import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/features/useful/presentation/created_workouts/presentation/bloc/created_workouts_bloc.dart';
import 'package:body_buddies/features/useful/presentation/created_workouts/presentation/created_workouts_screen.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatedWorkroutsPage extends StatelessWidget {
  const CreatedWorkroutsPage(
      {super.key,
      required this.usefulRepository,
      required this.secureStorage,
      required this.workoutsRepository});

  final UsefulRepository usefulRepository;
  final SecureStorage secureStorage;
  final WorkoutsRepository workoutsRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CreatedWorkoutsBloc(
          usefulRepository, secureStorage, workoutsRepository)
        ..add(FetchWorkoutsEvent()),
      child: const CreatedWorkoutsScreen(),
    );
  }
}
