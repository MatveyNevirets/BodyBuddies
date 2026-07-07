import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/local_workouts_repository.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/core/themes/app_consts.dart';

class LocalWorkoutsRepository implements WorkoutsRepository {
  LocalDatabase localDatabase;

  LocalWorkoutsRepository({required this.localDatabase});

  @override
  Future<void> addJournalWorkout(WorkoutEntity workout, String token) async {
    final database = await localDatabase.getDatabase();
    final workoutMap = {
      AppConsts.titleColumn: workout.title,
      AppConsts.weekdayColumn: workout.weekday.toString(),
      AppConsts.dateColumn: workout.date,
      AppConsts.durationColumn: workout.duration,
    };

    final journalWorkoutId =
        await database.insert(AppConsts.journalTable, workoutMap);

    for (ExerciseEntity entity in workout.exercises) {
      final exerciseMap = entity.toMap(workoutId: journalWorkoutId);

      await database.insert(AppConsts.journalExercisesTable, exerciseMap);
    }
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
  Future<void> deleteJournalWorkout(WorkoutEntity workout, String token) async {
    final database = await localDatabase.getDatabase();

    await database
        .delete(AppConsts.journalTable, where: "id=?", whereArgs: [workout.id]);
  }

  @override
  Future<void> deleteLocalDatabase() async {
    await localDatabase.deleteLocalDatabase();
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

      return newWorkout;
    }).toList();

    for (int i = 0; i < workouts.length; i++) {
      final id = workouts[i].id;

      final response = await database.query(AppConsts.exercisesTable,
          where: "workout_id=?", whereArgs: [id]);

      final exercises = response.map((exerciseMap) {
        return ExerciseEntity.fromMap(exerciseMap);
      }).toList();

      workouts[i].exercises = exercises;
    }
    return workouts;
  }

  @override
  Future<List<WorkoutEntity>> fetchJournalWorkouts(String token) async {
    final database = await localDatabase.getDatabase();

    final response = await database.query(AppConsts.journalTable);

    final workouts = response
        .map((workoutMap) => WorkoutEntity.fromMap(workoutMap))
        .toList();

    for (int i = 0; i < workouts.length; i++) {
      final id = workouts[i].id;

      final eResponse = await database.query(AppConsts.journalExercisesTable,
          where: "workout_id=?", whereArgs: [id]);

      final exercises = eResponse
          .map((exerciseMap) => ExerciseEntity.fromMap(exerciseMap))
          .toList();

      workouts[i].exercises = exercises;
    }

    return workouts;
  }

  @override
  String get name => "Local workouts repository";

  @override
  Future<void> updateWorkout(String? title, int? weekday,
      List<ExerciseEntity>? exercises, int index, String token) async {}
}
