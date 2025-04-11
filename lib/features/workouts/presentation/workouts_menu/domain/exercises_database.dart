import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';

class Exercises {
  List<ExerciseEntity> exercises = [
    ExerciseEntity(title: "Жим лежа", isExercise: true),
    ExerciseEntity(title: "Подъемы на бицепс", isExercise: true),
    ExerciseEntity(title: "Приседания", isExercise: true),
  ];

  add(Exercises createdExercise) {}
}
