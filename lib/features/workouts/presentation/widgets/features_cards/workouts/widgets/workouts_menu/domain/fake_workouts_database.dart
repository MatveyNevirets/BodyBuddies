import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_card_on_list.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';

class FakeWorkoutsDatabase {
  List<WorkoutEntity> fakeWorkoutEntities = [
    WorkoutEntity(
        title: "Легкая", mon: true, chest: true, biceps: true, forearms: true),
    WorkoutEntity(
        title: "Легкая среда", wen: true, back: true, triceps: true, abs: true),
    WorkoutEntity(
        title: "Легкая пятница", fri: true, legs: true, shoulders: true),
    WorkoutEntity(
        title: "Тяжелая жимовая",
        mon: true,
        chest: true,
        biceps: true,
        forearms: true),
    WorkoutEntity(
        title: "Тяжелая Тянущая",
        wen: true,
        back: true,
        triceps: true,
        abs: true),
    WorkoutEntity(
        title: "Тяжелый день ног", fri: true, legs: true, shoulders: true),
    WorkoutEntity(title: "Кардио на выходной", sun: true, cardio: true),
  ];

  WorkoutCardOnList getWorkout(int index) =>
      WorkoutCardOnList(workout: fakeWorkoutEntities[index]);
}
