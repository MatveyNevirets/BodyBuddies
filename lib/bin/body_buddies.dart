import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/features/home/presentation/bloc/home_bloc.dart';
import 'package:body_buddies/features/home/presentation/widgets/body_home_data.dart';
import 'package:body_buddies/features/home/presentation/widgets/home_screen.dart';
import 'package:body_buddies/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:body_buddies/features/intro/presentation/widgets/intro_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/bloc/run_workout_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/run_workout/presentation/run_workout_screen.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/workouts_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/exercises_database.dart';
import '../features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_create_entity/bloc/workout_create_entity_cubit.dart';
import '../features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_create_entity/presentation/workout_create_screen.dart';
import '../features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_create_entity/widgets/add_exercise/bloc/add_exercise_cubit.dart';
import '../features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_create_entity/widgets/add_exercise/presentation/add_exercise_screen.dart';
import '../features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_create_entity/widgets/add_exercise/widgets/add_your_exercise/bloc/add_your_exercise_cubit.dart';
import '../features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_create_entity/widgets/add_exercise/widgets/add_your_exercise/presentation/add_your_exercise_screen.dart';
import '../features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import '../features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/workout_entity_screen.dart';

void main() {
  runApp(BodyBuddiesApp());
}

class BodyBuddiesApp extends StatelessWidget {
  BodyBuddiesApp({super.key});

  FakeWorkoutsDatabase fakeWorkoutsDatabase = FakeWorkoutsDatabase();
  final BodyHomeData mainFrontendData = BodyHomeData();
  final exercises = Exercises();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Size screenSize = Size(
        MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height);

    WorkoutsMenuScreen workoutsMenuScreen = WorkoutsMenuScreen(
      mainFrontendData: mainFrontendData,
    );
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colours.bottom_bar_background_color,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colours.bottom_bar_background_color),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actionsIconTheme: IconThemeData(color: Colours.black_text_color),
      )),
      debugShowCheckedModeBanner: false,
      routes: {
        "/login_page": (context) => BlocProvider(
              create: (BuildContext context) => IntroBloc(),
              child: IntroScreen(),
            ),
        "/": (context) => BlocProvider(
              create: (BuildContext context) => HomeBloc(),
              child: HomeScreen(
                fakeWorkoutsDatabase: fakeWorkoutsDatabase,
                mainFrontendData: mainFrontendData,
              ),
            ),
        "/workouts_menu": (context) => BlocProvider(
              create: (BuildContext context) =>
                  WorkoutsMenuBloc(fakeWorkoutsDatabase),
              child: workoutsMenuScreen,
            ),
        "/workouts_menu/create_workout/": (context) => BlocProvider(
              create: (BuildContext context) => DialogCreateEntityCubit(),
              child: DialogWorkoutCreateScreen(
                fakeDB: fakeWorkoutsDatabase,
                workoutsMenuScreen: workoutsMenuScreen,
                onWorkoutCreated: () {
                  // context.read<WorkoutsMenuBloc>().add(AddWorkoutEvent());
                  Navigator.of(context).pop();
                },
                screenSize: screenSize,
                mainFrontendData: mainFrontendData,
              ),
            ),
        "/workouts_menu/create_workout/add_exercise/": (context) =>
            BlocProvider(
              create: (BuildContext context) => AddExerciseCubit(),
              child: AddExerciseScreen(
                mainFrontendData: mainFrontendData,
                exercises: exercises,
              ),
            ),
        "/workouts_menu/create_workout/add_exercise/add_your_exercise/":
            (context) => BlocProvider(
                  create: (BuildContext context) => AddYourExerciseCubit(),
                  child: AddYourExerciseScreen(
                    mainFrontendData: mainFrontendData,
                    exercises: exercises,
                  ),
                ),
        "workouts_menu/current_workout/": (context) => WorkoutEntityScreen(),
        "/run_workout/": (context) => RunWorkoutScreen(),
      },
      initialRoute: "/",
    );
  }
}
