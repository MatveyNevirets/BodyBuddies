// ignore_for_file: overridden_fields

import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';

class WorkoutModel extends WorkoutEntity {
  @override
  String? title;

  @override
  int weekday;

  @override
  @override
  @override
  @override
  @override
  @override
  @override
  @override
  @override
  bool chest, back, legs, biceps, triceps, forearms, shoulders, abs, cardio;

  @override
  @override
  String dateWhenTodo, allWorkoutLength;

  @override
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

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(title: json['title'], exercises: json['exercises']);
  }
}
