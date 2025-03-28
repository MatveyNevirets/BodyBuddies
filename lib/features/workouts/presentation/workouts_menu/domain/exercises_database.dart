import 'package:body_buddies/features/workouts/presentation/workouts_menu/domain/entity/exercise_entity.dart';

class Exercises {
  List<ExerciseEntity> exercises = [
    ExerciseEntity(title: "Жим лежа", chest: true, isExercise: true),
    ExerciseEntity(title: "Подъемы на бицепс", biceps: true, isExercise: true),
    ExerciseEntity(title: "Приседания", legs: true, isExercise: true),
  ];

  add(Exercises createdExercise) {}
}
