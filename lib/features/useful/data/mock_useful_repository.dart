import 'package:body_buddies/features/useful/domain/entity/advice_entity.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';

class MockUsefulRepository implements UsefulRepository {
  @override
  Future<List<ExerciseOnListEntity>> fetchExercises(String token) async {
    if (token != "") {
      await Future.delayed(const Duration(seconds: 2));
      return List.generate(
          10,
          (index) =>
              ExerciseOnListEntity(title: "$index exercise", isExercise: true));
    } else {
      throw Exception("Invalid token");
    }
  }

  @override
  String get name => "Mock useful repository";

  @override
  Future<List<AdviceEntity>> fetchAdvices(String token) async {
    if (token != "") {
      await Future.delayed(const Duration(seconds: 2));
      return [
        AdviceEntity(
            title: "Всё очень просто", bodyText: "Действительно, это так!"),
        AdviceEntity(
            title: "Как есть тортики и не набирать вес?",
            bodyText: "Ешь и не набирай. Каша мяса.")
      ];
    } else {
      throw Exception("Invalid token");
    }
  }

  @override
  Future<List<WorkoutEntity>> fetchCreatedWorkouts(String token) async {
    if (token != "") {
      await Future.delayed(const Duration(seconds: 2));
      return [
        WorkoutEntity(
          title: "Тяжёлая среда",
          weekday: 2,
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
                title: "Французский жим",
                kilograms: 37.5,
                reps: 8,
                sets: 3,
                restTimeInMinutes: 2,
                restTimeInSeconds: 0),
          ],
        ),
        WorkoutEntity(
          title: "Легкая ноги",
          weekday: 4,
          exercises: [
            ExerciseEntity(
                isExercise: false,
                title: "Планка",
                sets: 4,
                timerTimeMinutes: 2,
                timerTimeSeconds: 0,
                restTimeInMinutes: 3,
                restTimeInSeconds: 0),
            ExerciseEntity(
                isExercise: true,
                title: "Бицепс бедра",
                kilograms: 30,
                reps: 12,
                sets: 4,
                restTimeInMinutes: 3,
                restTimeInSeconds: 0)
          ],
        )
      ];
    } else {
      throw Exception("Invalid token");
    }
  }

  @override
  Future<void> addAdvice(String title, String body) {
    // TODO: implement addAdvice
    throw UnimplementedError();
  }

  @override
  Future<void> addExerciseOnList(String title, bool isExercise) {
    // TODO: implement addExerciseOnList
    throw UnimplementedError();
  }
}
