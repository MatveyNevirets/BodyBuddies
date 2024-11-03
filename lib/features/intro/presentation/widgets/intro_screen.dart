// ignore_for_file: use_key_in_widget_constructors

import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:body_buddies/features/intro/presentation/widgets/collect_characteristics_screen.dart';
import 'package:body_buddies/features/intro/presentation/widgets/login_intro_screen.dart';
import 'package:body_buddies/features/intro/presentation/widgets/registration_form_intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IntroBloc, IntroState>(
        builder: (context, state) {
          return Navigator(
            initialRoute: "intro/login",
            onGenerateRoute: (RouteSettings settings) {
              WidgetBuilder builder;

              switch (settings.name) {
                case "intro/login":
                  builder = (BuildContext context) => LoginIntroScreen(onRegistration: () {
                    Navigator.of(context).pushNamed("intro/registration");
                  },);
                  break;

                case "intro/registration":
                  builder = (BuildContext context) => RegistrationFormScreen(onSuccesRegisration: () {
                    Navigator.of(context).pushReplacementNamed("intro/collect_characteristics");
                  },);
                  break;

                case "intro/collect_characteristics":
                  builder = (BuildContext _) => CollectCharacteristicScreen(onSuccessCollect: () {
                    Navigator.of(context).pop();
                  },);
                  break;

                default:
                  throw Exception(Strings.navigator_exception);
              }

              return MaterialPageRoute(builder: builder, settings: settings);
            },
          );
        },
        listener: (context, state) {});
  }
}
