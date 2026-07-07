import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/features/useful/presentation/advices/presentation/advices_screen.dart';
import 'package:body_buddies/features/useful/presentation/advices/presentation/bloc/advices_bloc.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvicesPage extends StatelessWidget {
  const AdvicesPage(
      {super.key, required this.usefulRepository, required this.secureStorage});

  final UsefulRepository usefulRepository;
  final SecureStorage secureStorage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AdvicesBloc(usefulRepository, secureStorage)
            ..add(FetchAdvicesEvent()),
      child: const AdvicesScreen(),
    );
  }
}
