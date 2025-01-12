import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_card_on_list.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/add_card_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsMenuScreen extends StatelessWidget {
  FakeWorkoutsDatabase fakeDB;

  WorkoutsMenuScreen({required this.fakeDB});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutsMenuBloc, WorkoutsMenuState>(
        builder: (context, state) {
      return Scaffold(
        body: Container(
          margin: Styles.base_margin_size,
          child: ListView.builder(
              itemCount: fakeDB.fakeWorkoutEntities.length + 1,
              itemBuilder: (context, index) {
                return index == 0
                    ? AddCardEntity()
                    : fakeDB.getWorkout(index - 1);
              }),
        ),
      );
    }, buildWhen: (prev, curr) => curr is AddWorkoutState,);
  }
}
