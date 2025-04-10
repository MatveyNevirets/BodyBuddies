import 'package:body_buddies/features/useful/presentation/created_workouts/presentation/bloc/created_workouts_bloc.dart';
import 'package:body_buddies/features/useful/presentation/created_workouts/presentation/created_workouts_screen.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatedWorkroutsPage extends StatelessWidget {
  FakeWorkoutsDatabase fakeWorkoutsDatabase;
  CreatedWorkroutsPage({super.key, required this.fakeWorkoutsDatabase});

  @override
  Widget build(BuildContext context) {
    final depends = AppDependsProvider.of(context);

    return BlocProvider(
      create: (BuildContext context) =>
          CreatedWorkoutsBloc(depends.usefulRepository, depends.secureStorage)
            ..add(FetchWorkoutsEvent()),
      child: const CreatedWorkoutsScreen(),
    );
  }
}
