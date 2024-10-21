import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/widgets/features_cards/workouts_feature_card.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/water_indicator_widget/water_indicator_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/styles.dart';

class WorkoutsHomeScreen extends StatelessWidget {
  const WorkoutsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: Styles.base_margin_size,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(Strings.your_programs_string, style: Styles.appbar_text_style),
              const SizedBox(height: Styles.height_of_text_to_widget,),
              WorkoutFeatureCard(),
              SizedBox(
                height: Styles.big_height_of_text_to_widget / 1.5,
              ),
              Text(Strings.diet, style: Styles.appbar_text_style),
              const SizedBox(height: Styles.height_of_text_to_widget,),
              Center(
                child: WaterIndicatorWidget(),
              ),

            ],
          ),
        ));
  }
}
