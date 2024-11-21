import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chats_screen.dart';

class ChatsNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "chats_screen/",
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case "chats_screen/":
            builder = (BuildContext context) => ChatsScreen();
            break;

          default:
            throw Exception("Not found settings name: ${settings.name}");
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
