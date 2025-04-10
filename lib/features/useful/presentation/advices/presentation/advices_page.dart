import 'package:body_buddies/features/useful/presentation/advices/presentation/advices_screen.dart';
import 'package:body_buddies/features/useful/presentation/advices/presentation/bloc/advices_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvicesPage extends StatelessWidget {
  const AdvicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AdvicesBloc(),
      child: const AdvicesScreen(),
    );
  }
}
