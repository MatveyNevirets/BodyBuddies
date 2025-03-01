import 'package:body_buddies/features/useful/made_workouts/presentation/made_workouts_screen.dart';
import 'package:body_buddies/features/workouts/workouts_menu/domain/fake_workouts_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MadeWorkroutsPage extends StatelessWidget {
  FakeWorkoutsDatabase fakeWorkoutsDatabase;
  MadeWorkroutsPage({super.key, required this.fakeWorkoutsDatabase});

  @override
  Widget build(BuildContext context) {
    return MadeWorkoutsScreen(
      fakeWorkoutsDatabase: fakeWorkoutsDatabase,
    );
  }
}
