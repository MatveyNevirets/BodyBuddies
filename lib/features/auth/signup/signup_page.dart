import 'package:body_buddies/features/auth/signup/bloc/sign_up_bloc.dart';
import 'package:body_buddies/features/auth/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignUpBloc(),
      child: SignUpScreen(),
    );
  }
}
