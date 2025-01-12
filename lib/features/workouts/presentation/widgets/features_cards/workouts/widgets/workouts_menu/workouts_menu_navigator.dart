// import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/dialog_create_entity/presentation/dialog_workout_create_screen.dart';
// import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/workout_entity_screen.dart';
// import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/workouts_menu_screen.dart';
// import 'package:flutter/material.dart';
//
// class WorkoutsMenuNavigator extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     print("Nav return");
//     return WillPopScope(
//       onWillPop: () async {
//         print("Back");
//         return false;
//       },
//       child: Navigator(
//         initialRoute: "workouts_menu/",
//         onGenerateRoute: (RouteSettings settings) {
//           WidgetBuilder builder;
//
//           switch (settings.name) {
//             case "workouts_menu/":
//               builder = (BuildContext context) => WorkoutsMenuScreen();
//               break;
//
//             case "workouts_menu/current_workout/":
//               builder = (BuildContext context) => WorkoutEntityScreen();
//               break;
//
//             case "workouts_menu/create_workout/":
//               builder = (BuildContext context) => DialogWorkoutCreateScreen();
//               break;
//
//             default:
//               throw Exception(
//                   "Invalid route settings in workouts_menu_navigator, settings name: ${settings.name}");
//           }
//
//           return MaterialPageRoute(builder: builder, settings: settings);
//         },
//       ),
//     );
//   }
// }
