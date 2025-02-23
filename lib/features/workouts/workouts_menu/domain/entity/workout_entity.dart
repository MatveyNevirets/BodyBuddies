import 'package:body_buddies/features/workouts/workouts_menu/domain/entity/exercise_entity.dart';

class WorkoutEntity {
  String? title;
  int weekday;

  bool chest, back, legs, biceps, triceps, forearms, shoulders, abs, cardio;

  String dateWhenTodo, allWorkoutLength;

  List<ExerciseEntity> exercises = [];

  WorkoutEntity({
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
  });
}
