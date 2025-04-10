import 'package:body_buddies/features/useful/presentation/advices/presentation/advices_screen.dart';
import 'package:body_buddies/features/useful/presentation/advices/presentation/bloc/advices_bloc.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvicesPage extends StatelessWidget {
  const AdvicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final depends = AppDependsProvider.of(context);

    return BlocProvider(
      create: (BuildContext context) =>
          AdvicesBloc(depends.usefulRepository, depends.secureStorage)
            ..add(FetchAdvicesEvent()),
      child: const AdvicesScreen(),
    );
  }
}
