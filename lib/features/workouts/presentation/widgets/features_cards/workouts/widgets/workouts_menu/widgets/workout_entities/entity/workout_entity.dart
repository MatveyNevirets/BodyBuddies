import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';

class WorkoutEntity {
  String? title;
  int weekday;

  bool chest, back, legs, biceps, triceps, forearms, shoulders, abs, cardio;

  List<ExerciseEntity> exercises = [];

  WorkoutEntity({
    required this.title,
    required this.exercises,
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
