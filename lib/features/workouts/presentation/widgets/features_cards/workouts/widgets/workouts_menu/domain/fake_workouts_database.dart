import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_card_on_list.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';

class FakeWorkoutsDatabase {
  List<WorkoutEntity> fakeWorkoutEntities = [
    WorkoutEntity(
      title: "Легкая",
      weekday: 1,
      chest: true,
      biceps: true,
      forearms: true,
    ),
    WorkoutEntity(
        title: "Легкая среда",weekday: 2, back: true, triceps: true, abs: true),
    WorkoutEntity(
        title: "Легкая пятница", weekday: 5, legs: true, shoulders: true),
    WorkoutEntity(
        title: "Тяжелая жимовая",
       weekday: 4,
        chest: true,
        biceps: true,
        forearms: true),
    WorkoutEntity(
        title: "Тяжелая Тянущая",
        weekday: 3,
        back: true,
        triceps: true,
        abs: true),
    WorkoutEntity(
        title: "Тяжелая на грудь", weekday: 7, legs: true, shoulders: true),
    WorkoutEntity(title: "Кардио на выходной", weekday: 6, cardio: true),
  ];

  List<List<ExerciseEntity>> fakeWorkoutExercises = [
    [
      ExerciseEntity(title: "Отжимания", isExercise: true, reps: 25, sets: 4),
      ExerciseEntity(
          title: "Жим", isExercise: true, reps: 15, sets: 4, kilograms: 55),
      ExerciseEntity(
          title: "Гантели махи", isExercise: true, reps: 25, sets: 4),
      ExerciseEntity(
          title: "Присед", isExercise: true, reps: 25, sets: 4, kilograms: 40),
    ],
    [
      ExerciseEntity(title: "Хз но  да", isExercise: true, reps: 25, sets: 4),
      ExerciseEntity(
          title: "Жиаывавым",
          isExercise: true,
          reps: 15,
          sets: 4,
          kilograms: 55),
      ExerciseEntity(title: "фвыафа махи", isExercise: true, reps: 25, sets: 4),
      ExerciseEntity(
          title: "рфррфрфр",
          isExercise: true,
          reps: 25,
          sets: 4,
          kilograms: 40),
    ],
    [
      ExerciseEntity(
          title: "Гарик пожизненный на бицеас",
          isExercise: true,
          reps: 25,
          sets: 4),
      ExerciseEntity(
          title: "Жим", isExercise: true, reps: 15, sets: 4, kilograms: 55),
      ExerciseEntity(title: "Да махи", isExercise: true, reps: 13, sets: 4),
      ExerciseEntity(
          title: "Присед", isExercise: true, reps: 15, sets: 4, kilograms: 40),
    ],
    [
      ExerciseEntity(
          title: "Гарик пожизненный на бицеас",
          isExercise: true,
          reps: 25,
          sets: 4),
      ExerciseEntity(
          title: "Жим", isExercise: true, reps: 15, sets: 4, kilograms: 55),
      ExerciseEntity(title: "Да махи", isExercise: true, reps: 13, sets: 4),
      ExerciseEntity(
          title: "Присед", isExercise: true, reps: 15, sets: 4, kilograms: 40),
    ],
    [
      ExerciseEntity(
          title: "Гарик пожизненный на бицеас",
          isExercise: true,
          reps: 25,
          sets: 4),
      ExerciseEntity(
          title: "Жим", isExercise: true, reps: 15, sets: 4, kilograms: 55),
      ExerciseEntity(title: "Да махи", isExercise: true, reps: 13, sets: 4),
      ExerciseEntity(
          title: "Присед", isExercise: true, reps: 15, sets: 4, kilograms: 40),
    ],
    [
      ExerciseEntity(
          title: "Гарик пожизненный на бицеас",
          isExercise: true,
          reps: 25,
          sets: 4),
      ExerciseEntity(
          title: "Жим", isExercise: true, reps: 15, sets: 4, kilograms: 55),
      ExerciseEntity(title: "Да махи", isExercise: true, reps: 13, sets: 4),
      ExerciseEntity(
          title: "Присед", isExercise: true, reps: 15, sets: 4, kilograms: 40),
    ],
    [
      ExerciseEntity(
          title: "Гарик пожизненный на бицеас",
          isExercise: true,
          reps: 25,
          sets: 4),
      ExerciseEntity(
          title: "Жим", isExercise: true, reps: 15, sets: 4, kilograms: 55),
      ExerciseEntity(title: "Да махи", isExercise: true, reps: 13, sets: 4),
      ExerciseEntity(
          title: "Присед", isExercise: true, reps: 15, sets: 4, kilograms: 40),
    ],
  ];

  WorkoutCardOnList getWorkout(int index) => WorkoutCardOnList(
        workout: fakeWorkoutEntities[index],
        exercises: fakeWorkoutExercises[index],
      );
}
