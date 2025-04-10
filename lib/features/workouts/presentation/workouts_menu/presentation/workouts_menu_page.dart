import 'package:body_buddies/features/workouts/presentation/workouts_menu/presentation/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/presentation/workouts_menu_screen.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsMenuPage extends StatelessWidget {
  const WorkoutsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutsRepository =
        AppDependsProvider.of(context).workoutsRepository;

    return BlocProvider(
      create: (BuildContext context) => WorkoutsMenuBloc(workoutsRepository)
        ..add(UpdateWorkoutEvent(context: context)),
      child: const WorkoutsMenuScreen(),
    );
  }
}
