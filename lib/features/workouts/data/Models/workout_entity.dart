import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';

class WorkoutModel extends WorkoutEntity {
  String? title;

  int weekday;

  bool chest, back, legs, biceps, triceps, forearms, shoulders, abs, cardio;

  String dateWhenTodo, allWorkoutLength;

  List<ExerciseEntity> exercises = [];

  WorkoutModel({
    required this.title,
    required this.exercises,
    this.dateWhenTodo = "",
    this.allWorkoutLength = "",
    this.weekday = -1,
    this.abs = false,
    this.shoulders = false,
    this.legs = false,
    this.triceps = false,
    this.biceps = false,
    this.back = false,
    this.forearms = false,
    this.chest = false,
    this.cardio = false,
  }) : super(title: '', exercises: []);
}
