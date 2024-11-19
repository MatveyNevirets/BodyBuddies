import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/workouts_menu_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutsMenuNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "workouts_menu/",
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case "workouts_menu/":
            builder = (BuildContext context) => WorkoutsMenuScreen();
            break;

          default:
            throw Exception(
                "Invalid route settings in workouts_menu_navigator, settings name: ${settings.name}");
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
