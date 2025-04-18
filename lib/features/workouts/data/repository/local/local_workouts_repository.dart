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
    log("Success added workout with id: $id");
  }

  @override
  Future<void> deleteJournalWorkout(WorkoutEntity workout, String token) {
    // TODO: implement deleteJournalWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWorkout(int index, String token) {
    // TODO: implement deleteWorkout
    throw UnimplementedError();
  }

  @override
  Future<List<WorkoutEntity>> fetchAllWorkout(String token) async {
    final database = await localDatabase.getDatabase();

    final response = await database.query(AppConsts.workoutsTable);

    final workouts = response
        .map((workoutMap) => WorkoutEntity(
            title: workoutMap[AppConsts.titleColumn].toString(),
            exercises: [],
            weekday: int.parse(workoutMap[AppConsts.weekdayColumn].toString())))
        .toList();

    // workouts.map((workout) => );

    final eResponse = await database.query(AppConsts.exercisesTable);

    final exercises =
        eResponse.map((exerciseMap) => ExerciseEntity(title: "title"));

    log(response.toString());
    return workouts;
  }

  @override
  Future<List<WorkoutEntity>> fetchJournalWorkouts(String token) {
    // TODO: implement fetchJournalWorkouts
    throw UnimplementedError();
  }

  @override
  // TODO: implement name
  String get name => "Local workouts repository";

  @override
  Future<void> updateWorkout(String? title, int? weekday,
      List<ExerciseEntity>? exercises, int index, String token) {
    // TODO: implement updateWorkout
    throw UnimplementedError();
  }
}
