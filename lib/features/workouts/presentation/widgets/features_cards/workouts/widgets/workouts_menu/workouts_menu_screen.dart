import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_card_on_list.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/add_card_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutsMenuScreen extends StatefulWidget {
  @override
  State<WorkoutsMenuScreen> createState() => _WorkoutsMenuScreenState();
}

class _WorkoutsMenuScreenState extends State<WorkoutsMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: Styles.base_margin_size,
        child: ListView.builder(
            itemCount: FakeWorkoutsDatabase().fakeWorkoutEntities.length-1,
            itemBuilder: (context, index) {
              if(index==0) {
                return AddCardEntity();
              } else {
                return FakeWorkoutsDatabase().getWorkout(index-1);
              }
            }),
      ),
    );
  }
}
