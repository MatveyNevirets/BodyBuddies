// lib/internal/application/body_buddies_app.dart
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/auth/domain/repository/auth_repository.dart';
import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:body_buddies/core/themes/colors.dart';
import 'package:body_buddies/features/auth/presentation/auth_main/auth_page.dart';
import 'package:body_buddies/features/auth/presentation/signup/signup_screen.dart';
import 'package:body_buddies/features/workouts/presentation/add_exercise/presentation/add_exercise_page.dart';
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
import 'package:body_buddies/features/home/presentation/bloc/home_bloc.dart';
import 'package:body_buddies/features/home/presentation/home_screen.dart';

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
    // ============================================================
    //  ГЛОБАЛЬНОЕ ПЕРЕОПРЕДЕЛЕНИЕ СИСТЕМНЫХ ЭЛЕМЕНТОВ (Dark Theme)
    // ============================================================
    // Тёмный фон навигационной панели + светлые иконки.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // прозрачный статус-бар
        statusBarIconBrightness: Brightness.light, // светлые иконки статуса
        statusBarBrightness: Brightness.dark, // для iOS
        systemNavigationBarColor: DarkTheme.background, // тёмный низ
        systemNavigationBarIconBrightness: Brightness.light, // светлые кнопки
        systemNavigationBarDividerColor:
            Colors.transparent, // убираем разделитель
      ),
    );

    final Size screenSize = Size(
      MediaQuery.sizeOf(context).width,
      MediaQuery.sizeOf(context).height,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,

      // ================= LIGHT =================
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        cardColor: const Color(0xFFFFFFFF),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF1C1F26),
          onPrimary: Color(0xFFF4F6F8),
          secondary: Color(0xFF6B7280),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF1C1F26),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: Color(0xFF1C1F26),
          ),
          titleLarge: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4,
            color: Color(0xFF1C1F26),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1C1F26),
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Color(0xFF1C1F26),
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            // systemNavigationBarColor убираем – он не влияет глобально,
            // оставляем только для статус-бара
          ),
        ),
      ),

      // ================= DARK =================
      darkTheme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0F1115),
        cardColor: const Color(0xFF1A1F2B),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFD6D9DF),
          onPrimary: Color(0xFF0F1115),
          secondary: Color(0xFF6C768A),
          onSecondary: Color(0xFF0F1115),
          error: Colors.red,
          onError: Colors.white,
          surface: Color(0xFF1A1F2B),
          onSurface: Color(0xFFD6D9DF),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: Color(0xFFD6D9DF),
          ),
          titleLarge: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4,
            color: Color(0xFFD6D9DF),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFFD6D9DF),
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6C768A),
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6C768A),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Color(0xFFD6D9DF),
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
      ),

      // ================= ROUTES =================
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
