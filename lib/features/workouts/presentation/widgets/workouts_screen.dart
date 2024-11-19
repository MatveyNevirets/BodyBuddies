import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/workouts_menu_navigator.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/workouts_home_screen.dart';
import 'package:flutter/material.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "workouts/home",

      onGenerateRoute: (RouteSettings setting) {
        WidgetBuilder builder;

        switch(setting.name) {
          case "workouts/home":
            builder = (BuildContext context) => WorkoutsHomeScreen();
            break;

          case "workouts/home/workouts_menu/":
            builder = (BuildContext context) => WorkoutsMenuNavigator();
            break;

          default:
            throw Exception("Workout routes error: ${setting.name}");
        }

        return MaterialPageRoute(builder: builder, settings: setting);
      },
    );
  }
}