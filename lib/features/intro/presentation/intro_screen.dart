import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:body_buddies/features/intro/presentation/widgets/hello_intro_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IntroBloc, IntroState>(builder: (context, state) {
      return Navigator(
        initialRoute: "intro/hello",

        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;

          switch(settings.name) {
            case "intro/hello":
              builder = (BuildContext context) => HelloIntroScreen();
              break;

            default:
              throw Exception(Strings.navigator_exception);
          }

          return MaterialPageRoute(builder: builder, settings: settings);
        },
      );
    }, listener: (context, state) {

    });
  }
}