import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/features/water_indicator_widget/bloc/water_cups_bloc/water_cups_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: createAppBarWidget(
          appbarTitle: Strings.workouts_appbar, context: context),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(Strings.your_programs_string,
                  style: Styles.appbar_text_style),
              const SizedBox(
                height: Styles.height_of_text_to_widget,
              ),
              const WorkoutFeatureCard(),
              const SizedBox(
                height: Styles.big_height_of_text_to_widget / 1.5,
              ),
              Text(Strings.water, style: Styles.appbar_text_style),
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
              const SizedBox(
                height: Styles.big_height_of_text_to_widget / 1.5,
              ),
              Text(Strings.useful, style: Styles.appbar_text_style),
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
