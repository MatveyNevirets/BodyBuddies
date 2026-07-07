// ignore_for_file: use_build_context_synchronously

import 'package:body_buddies/core/themes/colors.dart';
import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/auth/presentation/auth_main/auth_main_screen.dart';
import 'package:body_buddies/features/auth/presentation/auth_main/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UserNotAuthtorized) {
          return LoginIntroScreen(
            onSignUp: () => _trySignUp(context),
            onSignIn: ({required String email, required String password}) {
              context
                  .read<AuthBloc>()
                  .add(SignInEvent(email: email, password: password));
            },
          );
        } else if (state is AuthLoadingState) {
          return const LoadingScreen();
        } else if (state is UserHasAuthtorized) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, "/");
          });
        }
        return const CircularProgressIndicator(
          color: Colours.base_button_color,
        );
      },
      listener: (BuildContext context, AuthState state) {
        if (state is SnackbarMessage) {
          showSnackBar(context, state.message.toString());
        }
      },
    );
  }

  void _trySignUp(BuildContext context) async {
    final response =
        await Navigator.pushNamed(context, "auth/signup") as List<String>?;

    if (response == null) {
      return null;
    } else {
      final email = response[0];
      final password = response[1];
      final username = response[2];

      context.read<AuthBloc>().add(
          SignUpEvent(email: email, password: password, username: username));
    }
  }
}
