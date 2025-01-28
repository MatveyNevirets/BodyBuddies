// import 'package:body_buddies/core/widgets/base_button.dart';
// import 'package:body_buddies/features/home/presentation/widgets/body_home_data.dart';
// import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_create_entity/presentation/workout_create_screen.dart';
// import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../../../../../../../../../../../core/colors/colors.dart';
// import '../../../../../../../../../../../../../../../core/strings/strings.dart';
// import '../../../../../../../../../../../../../../../core/styles/styles.dart';
// import '../../../../../bloc/workout_create_entity_cubit.dart';
//
// class ChangeExerciseSettingsScreen extends StatelessWidget {
//   final Size screenSize;
//
//   ChangeExerciseSettingsScreen({required this.screenSize});
//
//   TextEditingController weightController = TextEditingController();
//
//   late ExerciseEntity exercise;
//
//   @override
//   Widget build(BuildContext context) {
//     var getListOfArguments = ModalRoute.of(context)!.settings.arguments as List;
//
//     exercise = getListOfArguments[0] as ExerciseEntity;
//     BuildContext dialogCreateContext = getListOfArguments[1] as BuildContext;
//
//     return Scaffold(
//       appBar: createAppBarWidget(appbarTitle: Strings.filling),
//       body: Container(
//         margin: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             buildExerciseInputFields(),
//             SizedBox(
//               height: 16,
//             ),
//             buildRestOfSetsFields(),
//             SizedBox(
//               height: 16,
//             ),
//             BaseButton(
//               onClick: () => addExerciseToWorkout(context, dialogCreateContext),
//               buttonText: Strings.done,
//               icon: null,
//               isElevated: true,
//               backgroundColor: Colours.workout_card_background_color,
//               buttonSize: Size(double.maxFinite, 40),
//               radius: 8,
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void addExerciseToWorkout(
//       BuildContext context, BuildContext dialogCreateContext) {
//     exercise.kilograms = int.parse(weightController.text);
//
//     dialogCreateContext.read<DialogCreateEntityCubit>().addItem(exercise);
//     Navigator.of(context).pop();
//   }
//
//   Container buildExerciseInputFields() {
//     return Container(
//       child: Card(
//         child: Container(
//           padding: EdgeInsets.all(8),
//           decoration:
//               BoxDecoration(color: Colours.workout_card_background_color),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 width: screenSize.width / 7,
//                 height: 30,
//                 padding: EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                     color: Colours.workout_card_foreground_color,
//                     borderRadius: BorderRadius.circular(4)),
//                 child: TextField(
//                   controller: weightController,
//                   keyboardType: TextInputType.number,
//                   maxLength: 4,
//                   buildCounter: null,
//                   style: Styles.hint_text_field_fill_workout,
//                   cursorColor: Colours.workout_card_background_color,
//                   decoration: InputDecoration(
//                     enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                             width: 2,
//                             color: Colours.workout_card_background_color)),
//                     focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                             width: 2,
//                             color: Colours.workout_card_background_color)),
//                     hintText: Strings.weight,
//                     hintStyle: Styles.hint_text_field_fill_workout,
//                     contentPadding: EdgeInsets.only(bottom: 16),
//                     counterText: '',
//                   ),
//                 ),
//               ),
//               Expanded(child: SizedBox()),
//               Container(
//                 width: screenSize.width / 7,
//                 height: 30,
//                 padding: EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                     color: Colours.workout_card_foreground_color,
//                     borderRadius: BorderRadius.circular(4)),
//                 child: TextField(
//                   onChanged: (value) {
//                     exercise!.sets = int.parse(value);
//                   },
//                   maxLength: 4,
//                   buildCounter: null,
//                   keyboardType: TextInputType.number,
//                   style: Styles.hint_text_field_fill_workout,
//                   cursorColor: Colours.workout_card_background_color,
//                   decoration: InputDecoration(
//                     enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                             width: 2,
//                             color: Colours.workout_card_background_color)),
//                     focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                             width: 2,
//                             color: Colours.workout_card_background_color)),
//                     hintText: Strings.sets,
//                     hintStyle: Styles.hint_text_field_fill_workout,
//                     contentPadding: EdgeInsets.only(bottom: 16),
//                     counterText: '',
//                   ),
//                 ),
//               ),
//               Expanded(child: SizedBox()),
//               Container(
//                 width: screenSize.width / 7,
//                 height: 30,
//                 padding: EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                     color: Colours.workout_card_foreground_color,
//                     borderRadius: BorderRadius.circular(4)),
//                 child: TextField(
//                   onChanged: (value) {
//                     exercise!.reps = int.parse(value);
//                   },
//                   maxLength: 4,
//                   buildCounter: null,
//                   keyboardType: TextInputType.number,
//                   style: Styles.hint_text_field_fill_workout,
//                   cursorColor: Colours.workout_card_background_color,
//                   decoration: InputDecoration(
//                     enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                             width: 2,
//                             color: Colours.workout_card_background_color)),
//                     focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                             width: 2,
//                             color: Colours.workout_card_background_color)),
//                     hintText: Strings.reps,
//                     hintStyle: Styles.hint_text_field_fill_workout,
//                     contentPadding: EdgeInsets.only(bottom: 16),
//                     counterText: '',
//                   ),
//                 ),
//               ),
//               SizedBox(width: 8),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Container buildRestOfSetsFields() {
//     return Container(
//       padding: EdgeInsets.all(8),
//       color: Colours.workout_card_background_color,
//       child: Column(
//         children: [
//           Text(
//             Strings.rest_of_sets,
//             style: Styles.workout_exercise_card_style,
//           ),
//           SizedBox(
//             height: 6,
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: screenSize.width / 4,
//                 height: 30,
//                 padding: EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                     color: Colours.workout_card_foreground_color,
//                     borderRadius: BorderRadius.circular(4)),
//                 child: TextField(
//                   onChanged: (value) {
//                     exercise!.timerTimeMinutes = int.parse(value);
//                   },
//                   maxLength: 4,
//                   buildCounter: null,
//                   keyboardType: TextInputType.number,
//                   style: Styles.hint_text_field_fill_workout,
//                   cursorColor: Colours.workout_card_background_color,
//                   decoration: InputDecoration(
//                     enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                             width: 2,
//                             color: Colours.workout_card_background_color)),
//                     focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                             width: 2,
//                             color: Colours.workout_card_background_color)),
//                     hintText: Strings.minutes,
//                     hintStyle: Styles.hint_text_field_fill_workout,
//                     contentPadding: EdgeInsets.only(bottom: 16),
//                     counterText: '',
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: SizedBox(),
//               ),
//               Container(
//                 width: screenSize.width / 4,
//                 height: 30,
//                 padding: EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                     color: Colours.workout_card_foreground_color,
//                     borderRadius: BorderRadius.circular(4)),
//                 child: TextField(
//                   onChanged: (value) {
//                     exercise!.restTimeInSeconds = int.parse(value);
//                   },
//                   maxLength: 4,
//                   buildCounter: null,
//                   keyboardType: TextInputType.number,
//                   style: Styles.hint_text_field_fill_workout,
//                   cursorColor: Colours.workout_card_background_color,
//                   decoration: InputDecoration(
//                     enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                             width: 2,
//                             color: Colours.workout_card_background_color)),
//                     focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                             width: 2,
//                             color: Colours.workout_card_background_color)),
//                     hintText: Strings.seconds,
//                     hintStyle: Styles.hint_text_field_fill_workout,
//                     contentPadding: EdgeInsets.only(bottom: 16),
//                     counterText: '',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
