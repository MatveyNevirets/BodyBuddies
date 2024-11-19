import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_card_on_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutsMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: Styles.base_margin_size,
        child: ListView.builder(
            itemCount: FakeWorkoutsDatabase().fakeWorkoutEntities.length,
            itemBuilder: (context, index) {
              return FakeWorkoutsDatabase().getWorkout(index);
            }),
      ),
    );
  }
}
