// lib/internal/application/body_buddies_app.dart
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/auth/domain/repository/auth_repository.dart';
import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/features/auth/presentation/auth_main/auth_page.dart';
import 'package:body_buddies/features/auth/presentation/signup/signup_screen.dart';
import 'package:body_buddies/features/useful/presentation/add_exercise/presentation/add_exercise_page.dart';
import 'package:body_buddies/features/useful/presentation/advices/presentation/advices_page.dart';
import 'package:body_buddies/features/useful/presentation/advices/presentation/current_advice_screen.dart';
import 'package:body_buddies/features/useful/presentation/bench_press_calculator/presentation/bench_press_calculator_page.dart';
import 'package:body_buddies/features/useful/presentation/created_workouts/presentation/created_workouts_page.dart';
import 'package:body_buddies/features/workouts/presentation/add_your_exercise/presentation/add_your_exercise_screen.dart';
import 'package:body_buddies/features/workouts/presentation/add_your_exercise/presentation/bloc/add_your_exercise_cubit.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/workout_create_screen.dart';
import 'package:body_buddies/features/workouts/presentation/current_workout/presentation/current_workout_screen.dart';
import 'package:body_buddies/features/workouts/presentation/running_workout/presentation/workout_screen.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/journal_workouts_page.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/presentation/workouts_menu_page.dart';
import 'package:body_buddies/internal/home/presentation/bloc/home_bloc.dart';
import 'package:body_buddies/internal/home/presentation/home_screen.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:get_it/get_it.dart';

class BodyBuddiesApp extends StatelessWidget {
  const BodyBuddiesApp({
    super.key,
    required this.workoutsRepository,
    required this.usefulRepository,
    required this.secureStorage,
    required this.authRepository,
    required this.isConnection,
  });

  final WorkoutsRepository workoutsRepository;
  final UsefulRepository usefulRepository;
  final SecureStorage secureStorage;
  final AuthRepository authRepository;
  final bool isConnection;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = Size(
      MediaQuery.sizeOf(context).width,
      MediaQuery.sizeOf(context).height,
    );

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7FAFD),
        focusColor: Colours.workoutCardForegroundColor,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 22,
            color: Colours.workout_card_background_color,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            color: Colours.black_text_color,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Colours.black_text_color,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colours.black_text_color,
            fontWeight: FontWeight.w500,
          ),
        ),
        cardColor: Colours.workout_card_background_color,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2F80ED),
          brightness: Brightness.light,
          background: const Color(0xFFF7FAFD),
          surface: const Color(0xFFFFFFFF),
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colours.black_text_color),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xFFF7FAFD),
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Color(0xFFF7FAFD),
          ),
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          actionsIconTheme: IconThemeData(color: Colours.black_text_color),
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        focusColor: Colours.workoutCardForegroundColor,
        scaffoldBackgroundColor: Colours.dark_theme_background,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 22,
            color: Colours.white_text_color,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colours.white_text_color,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Colours.grey_text_color,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            color: Colours.white_text_color,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        cardColor: Colours.workout_card_background_color_dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2F80ED),
          brightness: Brightness.dark,
          background: Colours.dark_theme_background,
          surface: const Color(0xFF0E1D2D),
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colours.white_text_color),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black54,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black87,
          ),
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colours.dark_theme_background,
          actionsIconTheme: IconThemeData(color: Colours.white_text_color),
          elevation: 0,
        ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routes: {
        "auth/": (context) => AuthPage(
              authRepository: authRepository,
              secureStorage: secureStorage,
            ),
        "/": (context) => BlocProvider(
              create: (BuildContext context) => HomeBloc(),
              child: HomeScreen(
                workoutsRepository: workoutsRepository,
                secureStorage: secureStorage,
                isConnection: isConnection,
              ),
            ),
        "auth/signup": (context) => SignUpScreen(),
        "/workouts_menu": (context) => WorkoutsMenuPage(
            workoutsRepository: workoutsRepository,
            secureStorage: secureStorage,
            isConnection: isConnection),
        "/workouts_menu/create_workout/": (context) => CreateWorkoutScreen(
              screenSize: screenSize,
              workoutsRepository: workoutsRepository,
              secureStorage: secureStorage,
            ),
        "/workouts_menu/create_workout/add_exercise/": (context) =>
            AddExercisePage(
              usefulRepository: usefulRepository,
              secureStorage: secureStorage,
            ),
        "/workouts_menu/create_workout/add_exercise/add_your_exercise/":
            (context) => BlocProvider(
                  create: (BuildContext context) => AddYourExerciseCubit(),
                  child: const AddYourExerciseScreen(),
                ),
        "/workouts_menu/workouts_journal/": (context) => JournalWorkoutsPage(
              workoutsRepository: workoutsRepository,
              secureStorage: secureStorage,
              isConnection: isConnection,
            ),
        "workouts_menu/current_workout/": (context) =>
            const WorkoutEntityScreen(),
        "workouts_menu/run_workout/": (context) => WorkoutScreen(
              workoutsRepository: workoutsRepository,
              secureStorage: secureStorage,
            ),
        "/bench_press_calculator": (context) =>
            const BenchPressCalculatorPage(),
        "/advices": (context) => AdvicesPage(
              usefulRepository: usefulRepository,
              secureStorage: secureStorage,
            ),
        "/advices/current_advice": (context) => const CurrentAdviceScreen(),
        "/made_workouts": (context) => CreatedWorkroutsPage(
              usefulRepository: usefulRepository,
              secureStorage: secureStorage,
              workoutsRepository: workoutsRepository,
            ),
      },
      initialRoute: "/",
    );
  }
}
