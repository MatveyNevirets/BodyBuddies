import 'dart:developer';

import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/local_workouts_repository.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/internal/application/app_consts.dart';

class LocalWorkoutsRepository implements WorkoutsRepository {
  LocalDatabase localDatabase;

  LocalWorkoutsRepository({required this.localDatabase});

  @override
  Future<void> addJournalWorkout(WorkoutEntity workout, String token) {
    // TODO: implement addJournalWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> createWorkout(String title, int weekday,
      List<ExerciseEntity> exercises, String token) async {
    final database = await localDatabase.getDatabase();

    Map<String, dynamic> workoutsValue = {
      AppConsts.titleColumn: title,
      AppConsts.weekdayColumn: weekday
    };

    final id = await database.insert(AppConsts.workoutsTable, workoutsValue);

    for (ExerciseEntity exercise in exercises) {
      Map<String, dynamic> mapExercise = exercise.toMap(workoutId: id);
      await database.insert(AppConsts.exercisesTable, mapExercise);
    }
  }

  @override
  Future<void> deleteJournalWorkout(WorkoutEntity workout, String token) {
    // TODO: implement deleteJournalWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWorkout(int index, String token) async {
    final database = await localDatabase.getDatabase();

    final response = await database.query(AppConsts.workoutsTable);

    final workouts = response
        .map((workoutMap) => WorkoutEntity.fromMap(workoutMap))
        .toList();

    await database.delete(AppConsts.workoutsTable,
        where: "id=?", whereArgs: [workouts[index].id]);
  }

  @override
  Future<List<WorkoutEntity>> fetchAllWorkout(String token) async {
    final database = await localDatabase.getDatabase();

    final response = await database.query(AppConsts.workoutsTable);

    final workouts = response.map((workoutMap) {
      final newWorkout = WorkoutEntity.fromMap(workoutMap);

      log(newWorkout.id.toString());

      return newWorkout;
    }).toList();

    for (int i = 0; i < workouts.length; i++) {
      final id = workouts[i].id;

      final response = await database.query(AppConsts.exercisesTable,
          where: "workout_id=?", whereArgs: [id]);

      final exercises = response.map((exerciseMap) {
        log(exerciseMap.toString());
        return ExerciseEntity.fromMap(exerciseMap);
      }).toList();

      workouts[i].exercises = exercises;
    }
    return workouts;
  }

  @override
  Future<List<WorkoutEntity>> fetchJournalWorkouts(String token) {
    // TODO: implement fetchJournalWorkouts
    throw UnimplementedError();
  }

  @override
  String get name => "Local workouts repository";

  @override
  Future<void> updateWorkout(String? title, int? weekday,
      List<ExerciseEntity>? exercises, int index, String token) async {
    final database = await localDatabase.getDatabase();

    // final responseToAllWorkouts = await database.query(AppConsts.workoutsTable);
    // final workouts = responseToAllWorkouts
    //     .map((workoutMap) => WorkoutEntity.fromMap(workoutMap))
    //     .toList();

    // final response = await database.query(AppConsts.workoutsTable,
    //     where: "id=? AND title=?",
    //     whereArgs: [workouts[index].id, workouts[index].title]);

    // final workout = WorkoutEntity.fromMap(response[0]);

    // final updatedWorkout = {
    //   AppConsts.titleColumn: title ?? workout.title,
    //   AppConsts.weekdayColumn: weekday ?? workout.weekday
    // };

    // await database.update(AppConsts.workoutsTable, updatedWorkout);
  }
}
