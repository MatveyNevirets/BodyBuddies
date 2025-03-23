import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/features/auth/presentation/auth_main/auth_page.dart';
import 'package:body_buddies/features/auth/presentation/signup/signup_screen.dart';
import 'package:body_buddies/features/useful/advices/presentation/advices_page.dart';
import 'package:body_buddies/features/useful/advices/presentation/current_advice_screen.dart';
import 'package:body_buddies/features/useful/bench_press_calculator/presentation/bench_press_calculator_page.dart';
import 'package:body_buddies/features/useful/made_workouts/presentation/made_workouts_page.dart';
import 'package:body_buddies/features/workouts/add_exercise/bloc/add_exercise_cubit.dart';
import 'package:body_buddies/features/workouts/add_exercise/presentation/add_exercise_screen.dart';
import 'package:body_buddies/features/workouts/add_your_exercise/bloc/add_your_exercise_cubit.dart';
import 'package:body_buddies/features/workouts/add_your_exercise/presentation/add_your_exercise_screen.dart';
import 'package:body_buddies/features/workouts/create_workout/presentation/workout_create_screen.dart';
import 'package:body_buddies/features/workouts/current_workout/presentation/current_workout_screen.dart';
import 'package:body_buddies/features/workouts/workouts_menu/domain/exercises_database.dart';
import 'package:body_buddies/features/workouts/workouts_menu/presentation/workouts_menu_screen.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:body_buddies/internal/home/presentation/bloc/home_bloc.dart';
import 'package:body_buddies/features/workouts/workouts_menu/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/run_workout/presentation/run_workout_screen.dart';
import 'package:body_buddies/features/workouts/workouts_journal/bloc/workouts_journal_cubit.dart';
import 'package:body_buddies/features/workouts/workouts_journal/presentation/workouts_journal_screen.dart';
import 'package:body_buddies/internal/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyBuddiesApp extends StatelessWidget {
  BodyBuddiesApp({super.key});

  final fakeWorkoutsDatabase = FakeWorkoutsDatabase();
  final exercises = Exercises();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = Size(
        MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height);
    WorkoutsMenuScreen workoutsMenuScreen = WorkoutsMenuScreen();

    final appDepends = AppDependsProvider.of(context);

    return AppDependsProvider(
      appDepends: appDepends,
      child: MaterialApp(
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
          "/": (context) => BlocProvider(
                create: (BuildContext context) => HomeBloc(),
                child: HomeScreen(
                  fakeWorkoutsDatabase: fakeWorkoutsDatabase,
                ),
              ),
          "/auth": (context) => const AuthPage(),
          "/auth/signup": (context) => SignUpScreen(),
          "/workouts_menu": (context) => BlocProvider(
                create: (BuildContext context) =>
                    WorkoutsMenuBloc(fakeWorkoutsDatabase),
                child: workoutsMenuScreen,
              ),
          "/workouts_menu/create_workout/": (context) => CreateWorkoutScreen(
                fakeDB: fakeWorkoutsDatabase,
                workoutsMenuScreen: workoutsMenuScreen,
                screenSize: screenSize,
              ),
          "/workouts_menu/create_workout/add_exercise/": (context) =>
              BlocProvider(
                create: (BuildContext context) => AddExerciseCubit(),
                child: AddExerciseScreen(
                  exercises: exercises,
                ),
              ),
          "/workouts_menu/create_workout/add_exercise/add_your_exercise/":
              (context) => BlocProvider(
                    create: (BuildContext context) => AddYourExerciseCubit(),
                    child: AddYourExerciseScreen(
                      exercises: exercises,
                    ),
                  ),
          "/workouts_menu/workouts_journal/": (context) => BlocProvider(
              create: (BuildContext context) =>
                  WorkoutsJournalCubit(fakeWorkoutsDatabase),
              child: const WorkoutsJournalScreen()),
          "workouts_menu/current_workout/": (context) =>
              const WorkoutEntityScreen(),
          "workouts_menu/run_workout/": (context) => RunWorkoutScreen(
                fakeWorkoutsDatabase: fakeWorkoutsDatabase,
              ),
          "/bench_press_calculator": (context) =>
              const BenchPressCalculatorPage(),
          "/advices": (context) => const AdvicesPage(),
          "/advices/current_advice": (context) => const CurrentAdviceScreen(),
          "/made_workouts": (context) => MadeWorkroutsPage(
                fakeWorkoutsDatabase: fakeWorkoutsDatabase,
              ),
        },
        initialRoute: "/auth",
      ),
    );
  }
}
