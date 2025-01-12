import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/nutrition/nutrition_feature_card.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/useful/useful_feature_card.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/workouts_feature_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/styles.dart';
import 'features_cards/water_indicator_widget/bloc/water_cups_bloc/water_cups_bloc.dart';
import 'features_cards/water_indicator_widget/water_indicator_widget.dart';

class WorkoutsHomeScreen extends StatelessWidget {
  const WorkoutsHomeScreen({super.key, required this.fakeWorkoutsDatabase});

  final FakeWorkoutsDatabase fakeWorkoutsDatabase;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Styles.base_margin_size,
      child: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(Strings.your_programs_string,
                style: Styles.appbar_text_style),
            const SizedBox(
              height: Styles.height_of_text_to_widget,
            ),
            WorkoutFeatureCard(fakeDatabase: fakeWorkoutsDatabase,),
            SizedBox(
              height: Styles.big_height_of_text_to_widget / 1.5,
            ),
            Text(Strings.diet, style: Styles.appbar_text_style),
            const SizedBox(
              height: Styles.height_of_text_to_widget,
            ),
            Center(
                child: BlocProvider(
              create: (BuildContext context) {
                return WaterCupsBloc();
              },
              child: WaterIndicatorWidget(),
            )),
            SizedBox(
              height: Styles.big_height_of_text_to_widget / 1.5,
            ),
            NutritionFeatureCard(),
            SizedBox(
              height: Styles.big_height_of_text_to_widget / 1.5,
            ),
            Text(Strings.useful, style: Styles.appbar_text_style),
            const SizedBox(
              height: Styles.height_of_text_to_widget,
            ),
            UsefulFeatureCard(),
          ],
        ),
      ]),
    );
  }
}
