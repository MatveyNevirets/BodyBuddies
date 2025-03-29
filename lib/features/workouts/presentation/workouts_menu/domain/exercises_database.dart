import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';

class Exercises {
  List<ExerciseEntity> exercises = [
    ExerciseEntity(title: "Жим лежа", chest: true, isExercise: true),
    ExerciseEntity(title: "Подъемы на бицепс", biceps: true, isExercise: true),
    ExerciseEntity(title: "Приседания", legs: true, isExercise: true),
  ];

  add(Exercises createdExercise) {}
}
