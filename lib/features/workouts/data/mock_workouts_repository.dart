import 'dart:developer';

import 'package:body_buddies/features/workouts/data/Models/exercise_entity.dart';
import 'package:body_buddies/features/workouts/data/Models/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';

class MockWorkoutsRepository implements WorkoutsRepository {
  @override
  Future<List<WorkoutModel>> fetchAllWorkout() async {
    await Future.delayed(const Duration(seconds: 3));
    log("Loading has been ended");
    return _workouts;
  }

  @override
  String get name => "Mock workouts repository";

  @override
  Future<void> createWorkout(
      String title, int weekday, List<ExerciseEntity> exercises) async {
    _workouts.add(
        WorkoutModel(title: title, weekday: weekday, exercises: exercises));
  }

  @override
  Future<void> deleteWorkout(int index) async {
    _workouts.removeAt(index);
  }

  @override
  Future<void> updateWorkout(String? title, int? weekday,
      List<ExerciseEntity>? exercises, int index) async {
    _workouts[index].title = title ?? _workouts[index].title;
    _workouts[index].weekday = weekday ?? _workouts[index].weekday;
    _workouts[index].exercises = exercises ?? _workouts[index].exercises;
  }
}

final List<WorkoutModel> _workouts = [
  WorkoutModel(
    title: "Тяжёлая среда",
    weekday: 2,
    back: true,
    triceps: true,
    exercises: [
      ExerciseModel(
          isExercise: true,
          title: "Подтягивания",
          kilograms: 30,
          restTimeInMinutes: 3,
          restTimeInSeconds: 0,
          sets: 5,
          reps: 6),
      ExerciseModel(
          isExercise: true,
          title: "Тяга штанги в наклоне",
          kilograms: 75,
          sets: 4,
          reps: 6,
          restTimeInSeconds: 0,
          restTimeInMinutes: 3),
      ExerciseModel(
          isExercise: true,
          title: "Тяга широчайшей (верх. блок)",
          kilograms: 47.5,
          sets: 4,
          reps: 6,
          restTimeInMinutes: 3,
          restTimeInSeconds: 0),
      ExerciseModel(
          isExercise: true,
          title: "Жим трицепс (верх. блок)",
          kilograms: 67.5,
          reps: 6,
          sets: 4,
          restTimeInMinutes: 2,
          restTimeInSeconds: 0),
      ExerciseModel(
          isExercise: true,
          title: "Французский жим",
          kilograms: 37.5,
          reps: 8,
          sets: 3,
          restTimeInMinutes: 2,
          restTimeInSeconds: 0),
    ],
  ),
  WorkoutModel(
    title: "Легкая ноги",
    weekday: 4,
    legs: true,
    shoulders: true,
    exercises: [
      ExerciseModel(
          isExercise: true,
          title: "Икры штанга",
          kilograms: 70,
          restTimeInMinutes: 3,
          restTimeInSeconds: 0,
          sets: 4,
          reps: 20),
      ExerciseModel(
          isExercise: true,
          title: "Жим лёжа",
          kilograms: 65,
          sets: 4,
          reps: 10,
          restTimeInSeconds: 0,
          restTimeInMinutes: 3),
      ExerciseModel(
          isExercise: true,
          title: "Квадры в тренажёре",
          kilograms: 70,
          sets: 4,
          reps: 15,
          restTimeInMinutes: 3,
          restTimeInSeconds: 0),
      ExerciseModel(
          isExercise: true,
          title: "Бицепс бедра",
          kilograms: 30,
          reps: 12,
          sets: 4,
          restTimeInMinutes: 3,
          restTimeInSeconds: 0),
      ExerciseModel(
          isExercise: true,
          title: "Приседания",
          kilograms: 60,
          reps: 12,
          sets: 4,
          restTimeInMinutes: 3,
          restTimeInSeconds: 0),
      ExerciseModel(
          isExercise: true,
          title: "Армейский жим",
          kilograms: 30,
          reps: 12,
          sets: 4,
          restTimeInMinutes: 2,
          restTimeInSeconds: 0),
      ExerciseModel(
          isExercise: true,
          title: "Махи гантелями",
          kilograms: 17.5,
          reps: 20,
          sets: 4,
          restTimeInMinutes: 2,
          restTimeInSeconds: 0),
    ],
  ),
  WorkoutModel(
      title: "Timer Exerc",
      exercises: [
        ExerciseModel(
            isTimerExercise: true,
            title: "Берпс",
            kilograms: 5,
            restTimeInMinutes: 0,
            restTimeInSeconds: 5,
            timerTimeMinutes: 0,
            timerTimeSeconds: 10,
            sets: 3),
      ],
      weekday: 2,
      legs: true,
      cardio: true),
  WorkoutModel(
    title: "Ношке наказание",
    weekday: 1,
    legs: true,
    shoulders: true,
    exercises: [
      ExerciseModel(
          isExercise: true,
          title: "Икры штанга",
          kilograms: 70,
          restTimeInMinutes: 3,
          restTimeInSeconds: 0,
          sets: 4,
          reps: 20),
      ExerciseModel(
          isExercise: true,
          title: "Жим лёжа",
          kilograms: 75,
          sets: 4,
          reps: 10,
          restTimeInSeconds: 0,
          restTimeInMinutes: 3),
      ExerciseModel(
          isExercise: true,
          title: "Квадры в тренажёре",
          kilograms: 85,
          sets: 4,
          reps: 15,
          restTimeInMinutes: 3,
          restTimeInSeconds: 0),
      ExerciseModel(
          isExercise: true,
          title: "Бицепс бедра",
          kilograms: 35,
          reps: 12,
          sets: 4,
          restTimeInMinutes: 3,
          restTimeInSeconds: 0),
      ExerciseModel(
          isExercise: true,
          title: "Приседания",
          kilograms: 65,
          reps: 12,
          sets: 4,
          restTimeInMinutes: 3,
          restTimeInSeconds: 0),
      ExerciseModel(
          isExercise: true,
          title: "Армейский жим",
          kilograms: 42.5,
          reps: 12,
          sets: 4,
          restTimeInMinutes: 2,
          restTimeInSeconds: 0),
      ExerciseModel(
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
