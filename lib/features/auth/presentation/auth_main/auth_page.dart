import 'package:body_buddies/features/auth/domain/repository/auth_repository.dart';
import 'package:body_buddies/features/auth/presentation/auth_main/auth_screen.dart';
import 'package:body_buddies/features/auth/presentation/auth_main/bloc/auth_bloc.dart';

import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage(
      {super.key, required this.authRepository, required this.secureStorage});

  final AuthRepository authRepository;
  final SecureStorage secureStorage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AuthBloc(authRepository, secureStorage)..add(AuthInitEvent()),
      child: const AuthScreen(),
    );
  }
}
