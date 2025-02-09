import 'package:body_buddies/features/home/presentation/widgets/body_home_data.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/workouts_journal/bloc/workouts_journal_cubit.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/workouts_journal/widgets/journal_workout_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../core/colors/colors.dart';
import '../../../../../../../../../../core/strings/strings.dart';

class WorkoutsJournalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBarWidget(appbarTitle: Strings.journal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colours.workout_card_background_color,
          child: Container(
            padding: EdgeInsets.all(16),
            child: BlocBuilder<WorkoutsJournalCubit, List<WorkoutEntity>>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (BuildContext context, int index) {
                    return JournalWorkoutCardItem(
                        state[index]);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
