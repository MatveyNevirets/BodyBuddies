import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/assets/icons/flutter-icons-ef864561/bottom_icons_icons.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/base_bottom_navigation_bar_item.dart';
import 'package:body_buddies/features/home/presentation/widgets/body_home_data.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/water_indicator_widget/bloc/water_cups_bloc/water_cups_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/strings.dart';
import '../../../workouts/presentation/widgets/features_cards/nutrition/nutrition_feature_card.dart';
import '../../../workouts/presentation/widgets/features_cards/useful/useful_feature_card.dart';
import '../../../workouts/presentation/widgets/features_cards/water_indicator_widget/water_indicator_widget.dart';
import '../../../workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/workouts_menu_navigator.dart';
import '../../../workouts/presentation/widgets/features_cards/workouts/workouts_feature_card.dart';
import '../../../workouts/presentation/widgets/workouts_home_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final data = BodyHomeData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: data.createAppBarWidget(appbarTitle: Strings.workouts_appbar),
      body: Container(
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
              WorkoutFeatureCard(),
              const SizedBox(
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
              const SizedBox(
                height: Styles.big_height_of_text_to_widget / 1.5,
              ),
              NutritionFeatureCard(),
              const SizedBox(
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
      ),
    );
  }
}
