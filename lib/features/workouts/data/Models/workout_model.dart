import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';

class WorkoutModel extends WorkoutEntity {
  WorkoutModel(
      {required super.title,
      required super.exercises,
      required super.weekday,
      super.date,
      super.duration});

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
        title: json['title'],
        exercises: json['exercises'],
        weekday: json['weekday']);
  }
}
