import 'package:body_buddies/features/auth/presentation/signup/bloc/sign_up_bloc.dart';
import 'package:body_buddies/features/auth/presentation/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignUpBloc(),
      child: SignUpScreen(),
    );
  }
}
