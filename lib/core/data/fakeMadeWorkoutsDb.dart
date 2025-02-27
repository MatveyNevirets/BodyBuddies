import 'package:body_buddies/features/workouts/workouts_menu/domain/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/workouts_menu/domain/entity/workout_entity.dart';

abstract class FakeMadeWorkoutsDb {
  static List<WorkoutEntity> workouts = [
    WorkoutEntity(
      title: "Сжечь жир! Я сказал! Сжечь!",
      back: true,
      forearms: true,
      weekday: 1,
      exercises: [
        ExerciseEntity(
            isExercise: true,
            title: "Подтягивания",
            kilograms: 30,
            restTimeInMinutes: 3,
            restTimeInSeconds: 0,
            sets: 5,
            reps: 6),
        ExerciseEntity(
            isExercise: true,
            title: "Тяга штанги в наклоне",
            kilograms: 75,
            sets: 4,
            reps: 6,
            restTimeInSeconds: 0,
            restTimeInMinutes: 3),
        ExerciseEntity(
            isExercise: true,
            title: "Тяга широчайшей (верх. блок)",
            kilograms: 47.5,
            sets: 4,
            reps: 6,
            restTimeInMinutes: 3,
            restTimeInSeconds: 0),
        ExerciseEntity(
            isExercise: true,
            title: "Жим трицепс (верх. блок)",
            kilograms: 67.5,
            reps: 6,
            sets: 4,
            restTimeInMinutes: 2,
            restTimeInSeconds: 0),
        ExerciseEntity(
            isExercise: true,
            title: "Французский жим",
            kilograms: 37.5,
            reps: 8,
            sets: 3,
            restTimeInMinutes: 2,
            restTimeInSeconds: 0),
      ],
    ),
    WorkoutEntity(
      title: "Тяжелая Full-body",
      chest: true,
      back: true,
      weekday: 3,
      exercises: [
        ExerciseEntity(
            isExercise: true,
            title: "Икры штанга",
            kilograms: 70,
            restTimeInMinutes: 3,
            restTimeInSeconds: 0,
            sets: 4,
            reps: 20),
        ExerciseEntity(
            isExercise: true,
            title: "Жим лёжа",
            kilograms: 75,
            sets: 4,
            reps: 10,
            restTimeInSeconds: 0,
            restTimeInMinutes: 3),
        ExerciseEntity(
            isExercise: true,
            title: "Квадры в тренажёре",
            kilograms: 85,
            sets: 4,
            reps: 15,
            restTimeInMinutes: 3,
            restTimeInSeconds: 0),
        ExerciseEntity(
            isExercise: true,
            title: "Бицепс бедра",
            kilograms: 35,
            reps: 12,
            sets: 4,
            restTimeInMinutes: 3,
            restTimeInSeconds: 0),
        ExerciseEntity(
            isExercise: true,
            title: "Приседания",
            kilograms: 65,
            reps: 12,
            sets: 4,
            restTimeInMinutes: 3,
            restTimeInSeconds: 0),
        ExerciseEntity(
            isExercise: true,
            title: "Армейский жим",
            kilograms: 42.5,
            reps: 12,
            sets: 4,
            restTimeInMinutes: 2,
            restTimeInSeconds: 0),
        ExerciseEntity(
            isExercise: true,
            title: "Махи гантелями",
            kilograms: 25,
            reps: 20,
            sets: 4,
            restTimeInMinutes: 2,
            restTimeInSeconds: 0),
      ],
    ),
  ];
}
