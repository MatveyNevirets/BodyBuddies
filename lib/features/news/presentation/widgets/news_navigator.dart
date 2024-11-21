import 'package:body_buddies/features/news/presentation/widgets/news_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsNavigator extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "screen/",
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case "screen/":
            builder = (BuildContext context) => NewsScreen();
            break;

          default:
            throw Exception("Not found navigator settings name: ${settings.name}");
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}