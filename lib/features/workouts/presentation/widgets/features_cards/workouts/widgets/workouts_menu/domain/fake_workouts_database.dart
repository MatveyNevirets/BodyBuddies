import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';

class FakeWorkoutsDatabase {
  List<WorkoutEntity> fakeWorkoutEntities = [
    WorkoutEntity(
      title: "Тяжёлая среда",
      weekday: 2,
      back: true,
      triceps: true,
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
  ];

  WorkoutEntity getWorkout(int index) => fakeWorkoutEntities[index];
}
