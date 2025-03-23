import 'dart:developer';

import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/auth/presentation/auth_main/auth_main_screen.dart';
import 'package:body_buddies/features/auth/presentation/auth_main/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ErrorState) showSnackBar(context, state.message);
      },
      builder: (context, state) {
        if (state is UserNotAuthtorized) {
          return LoginIntroScreen(
            onSignUp: () async {
              final response =
                  await Navigator.pushNamed(context, "/auth/signup")
                      as List<String>;
              final email = response[0];
              final password = response[1];
              final username = response[2];

              context
                  .read<AuthBloc>()
                  .add(SignUpEvent(email, password, username));
            },
            onSignIn: () => Navigator.pop(context),
          );
        } else if (state is AuthLoadingState) {
          return LoadingScreen();
        } else if (state is UserHasAuthtorized) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
          });
        }
        return const CircularProgressIndicator(
          color: Colours.base_button_color,
        );
      },
    );
  }
}
