import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:body_buddies/features/intro/presentation/intro_screen.dart';
import 'package:flutter/material.dart';
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
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (BuildContext context) => IntroBloc(),
        child: IntroScreen(),
      ),
    );
  }
}
