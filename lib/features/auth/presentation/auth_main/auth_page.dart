import 'package:body_buddies/features/auth/presentation/auth_main/auth_screen.dart';
import 'package:body_buddies/features/auth/presentation/auth_main/bloc/auth_bloc.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AppDependsProvider.of(context).repository;

    return BlocProvider(
      create: (BuildContext context) => AuthBloc(authRepository),
      child: const AuthScreen(),
    );
  }
}
