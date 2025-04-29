import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import '../../../core/strings/strings.dart';
import '../../../features/useful/useful_feature_card/presentation/useful_feature_card.dart';
import '../../../features/water_indicator_widget/water_indicator_widget.dart';
import '../../../features/workouts/presentation/workout_feature_card/presentation/workouts_feature_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: createAppBarWidget(
          appbarTitle: Strings.workouts_appbar, context: context),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Strings.your_programs_string,
                  style: theme.textTheme.titleLarge),
              const SizedBox(
                height: Styles.height_of_text_to_widget,
              ),
              const WorkoutFeatureCard(),
              const SizedBox(
                height: Styles.big_height_of_text_to_widget / 1.5,
              ),
              Text(Strings.water, style: theme.textTheme.titleLarge),
              const SizedBox(
                height: Styles.height_of_text_to_widget,
              ),
              Center(
                child: WaterIndicatorWidget(),
              ),
              const SizedBox(
                height: Styles.big_height_of_text_to_widget / 1.5,
              ),
              Text(Strings.useful, style: theme.textTheme.titleLarge),
              const SizedBox(
                height: Styles.height_of_text_to_widget,
              ),
              const UsefulFeatureCard(),
            ],
          ),
        ),
      ]),
    );
  }
}
