import 'package:body_buddies/features/workouts/presentation/add_exercise/bloc/exercises_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/add_exercise/presentation/add_exercise_screen.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExercisePage extends StatelessWidget {
  const AddExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutRepository = AppDependsProvider.of(context).workoutsRepository;

    return BlocProvider(
      create: (BuildContext context) =>
          ExercisesBloc(workoutRepository)..add(InitializeEvent(context)),
      child: AddExerciseScreen(),
    );
  }
}
