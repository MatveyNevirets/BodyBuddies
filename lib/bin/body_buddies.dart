import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/features/home/presentation/bloc/home_bloc.dart';
import 'package:body_buddies/features/home/presentation/widgets/home_screen.dart';
import 'package:body_buddies/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:body_buddies/features/intro/presentation/widgets/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const BodyBuddiesApp());
}

class BodyBuddiesApp extends StatelessWidget {
  const BodyBuddiesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colours.bottom_bar_background_color,
            statusBarIconBrightness:  Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colours.bottom_bar_background_color
        ),
        backgroundColor: Colors.transparent,
        actionsIconTheme: IconThemeData(color: Colours.black_text_color),
      )),
      debugShowCheckedModeBanner: false,
      routes: {
        "/introduction": (context) => BlocProvider(
              create: (BuildContext context) => IntroBloc(),
              child: IntroScreen(),
            ),
        "/": (context) => BlocProvider(
              create: (BuildContext context) => HomeBloc(),
              child: HomeScreen(),
            )
      },
      initialRoute: "/introduction",
    );
  }
}
