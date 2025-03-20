import 'package:body_buddies/features/auth/presentation/auth_main/auth_main_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginIntroScreen(
      onSignUp: () => Navigator.pushNamed(context, "/auth/signup"),
      onSignIn: () => Navigator.pop(context),
    );
  }
}
