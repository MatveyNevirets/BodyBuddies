import 'package:body_buddies/core/styles/styles.dart';
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
import 'package:body_buddies/features/workouts/presentation/run_workout/presentation/run_workout_screen.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_journal/presentation/journal_workouts_page.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/presentation/workouts_menu_page.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:body_buddies/internal/home/presentation/bloc/home_bloc.dart';
import 'package:body_buddies/internal/home/presentation/home_screen.dart';

class BodyBuddiesApp extends StatelessWidget {
  const BodyBuddiesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = Size(
        MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height);

    final appDepends = AppDependsProvider.of(context);

    return AppDependsProvider(
      appDepends: appDepends,
      child: MaterialApp(
        theme: ThemeData(
            focusColor: Colours.workoutCardForegroundColor,
            textTheme: TextTheme(
              bodyLarge: Styles.title_blue_text_style,
              titleLarge: Styles.appbar_text_style,
              // headlineSmall: Styles.,
              bodySmall: Styles.small_dark_boxes_text,
              bodyMedium: Styles.workout_text_style_dark_theme,
            ),
            cardColor: Colours.workout_card_background_color,
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colours.black_text_color),
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colours.bottom_bar_background_color,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarIconBrightness: Brightness.dark,
                  systemNavigationBarColor:
                      Colours.bottom_bar_background_color),
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              actionsIconTheme: IconThemeData(color: Colours.black_text_color),
            )),

///////DARK////////THEME//////

        darkTheme: ThemeData(
            focusColor: Colours.workoutCardForegroundColor,
            scaffoldBackgroundColor: Colours.dark_theme_background,
            textTheme: TextTheme(
                // headlineSmall: Styles.,
                bodyLarge: Styles.title_blue_text_style,
                bodyMedium: Styles.workout_text_style_dark_theme,
                bodySmall: Styles.small_dark_boxes_text_dark_theme,
                titleLarge: Styles.appbar_text_style_dark_theme),

            /////APP--BAR/////////
            cardColor: Colours.workout_card_background_color_dark,
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colours.white_text_color),
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black54,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarIconBrightness: Brightness.light,
                  systemNavigationBarColor: Colors.black87),
              surfaceTintColor: Colors.black54,
              backgroundColor: Colours.dark_theme_background,
              actionsIconTheme: IconThemeData(color: Colours.white_text_color),
            )),

        ////////

        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routes: {
          "auth/": (context) => const AuthPage(),
          "/": (context) => BlocProvider(
                create: (BuildContext context) => HomeBloc(),
                child: const HomeScreen(),
              ),
          "auth/signup": (context) => SignUpScreen(),
          "/workouts_menu": (context) => const WorkoutsMenuPage(),
          "/workouts_menu/create_workout/": (context) => CreateWorkoutScreen(
                screenSize: screenSize,
              ),
          "/workouts_menu/create_workout/add_exercise/": (context) =>
              const AddExercisePage(),
          "/workouts_menu/create_workout/add_exercise/add_your_exercise/":
              (context) => BlocProvider(
                    create: (BuildContext context) => AddYourExerciseCubit(),
                    child: const AddYourExerciseScreen(),
                  ),
          "/workouts_menu/workouts_journal/": (context) =>
              const JournalWorkoutsPage(),
          "workouts_menu/current_workout/": (context) =>
              const WorkoutEntityScreen(),
          "workouts_menu/run_workout/": (context) => const RunWorkoutScreen(),
          "/bench_press_calculator": (context) =>
              const BenchPressCalculatorPage(),
          "/advices": (context) => const AdvicesPage(),
          "/advices/current_advice": (context) => const CurrentAdviceScreen(),
          "/made_workouts": (context) => const CreatedWorkroutsPage(),
        },
        initialRoute: "auth/",
      ),
    );
  }
}
