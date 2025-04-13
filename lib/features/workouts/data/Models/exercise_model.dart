// ignore_for_file: overridden_fields

import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';

class ExerciseModel extends ExerciseEntity {
  ExerciseModel(
      {required super.title,
      super.currentSets = 1,
      super.reps = 0,
      super.sets = 0,
      super.timerTimeSeconds = 0,
      super.timerTimeMinutes = 0,
      super.kilograms = 0,
      super.restTimeInMinutes = 0,
      super.restTimeInSeconds = 0,
      super.isTimerExercise = false,
      super.isExercise = false});
}
