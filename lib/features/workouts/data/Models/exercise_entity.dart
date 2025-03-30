import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';

class ExerciseModel extends ExerciseEntity {
  @override
  String title;

  @override
  @override
  @override
  @override
  @override
  @override
  @override
  @override
  @override
  bool chest,
      legs,
      shoulders,
      forearms,
      triceps,
      biceps,
      abs,
      isExercise,
      isTimerExercise;

  @override
  @override
  @override
  @override
  @override
  @override
  @override
  int sets,
      currentSets,
      reps,
      timerTimeSeconds,
      timerTimeMinutes,
      restTimeInSeconds,
      restTimeInMinutes;

  @override
  double kilograms;

  ExerciseModel(
      {required this.title,
      this.chest = false,
      this.legs = false,
      this.currentSets = 1,
      this.shoulders = false,
      this.forearms = false,
      this.triceps = false,
      this.biceps = false,
      this.abs = false,
      this.reps = 0,
      this.sets = 0,
      this.timerTimeSeconds = 0,
      this.timerTimeMinutes = 0,
      this.kilograms = 0,
      this.restTimeInMinutes = 0,
      this.restTimeInSeconds = 0,
      this.isTimerExercise = false,
      this.isExercise = false})
      : super(title: '');
}
