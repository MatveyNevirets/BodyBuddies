import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';

class WorkoutEntity {
  String? title;
  int weekday;

  String date, duration;

  List<ExerciseEntity> exercises = [];

  WorkoutEntity({
    required this.title,
    required this.exercises,
    this.date = "",
    this.duration = "",
    this.weekday = -1,
  });
}
