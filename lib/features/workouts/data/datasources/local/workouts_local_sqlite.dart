import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/domain/local_workouts_repository.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

class WorkoutsLocalSQLite implements LocalWorkoutsRepository {
  @override
  Future<void> addJournalWorkout(WorkoutEntity workout) {
    // TODO: implement addJournalWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> createWorkout(
      String title, int weekday, List<ExerciseEntity> exercises) {
    // TODO: implement createWorkout
    throw UnimplementedError();
  }

  @override
  Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    try {
      await initDatabase();
      return _database!;
    } on Object catch (error, stack) {
      throw Exception(
          "GET LOCAL WORKOUTS DATABASE ERROR: $error STACKTRACE: $stack");
    }
  }

  @override
  Future<void> deleteJournalWorkout(WorkoutEntity workout) {
    // TODO: implement deleteJournalWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWorkout(int index) {
    // TODO: implement deleteWorkout
    throw UnimplementedError();
  }

  @override
  Future<List<WorkoutEntity>> fetchAllWorkout() {
    // TODO: implement fetchAllWorkout
    throw UnimplementedError();
  }

  @override
  Future<List<WorkoutEntity>> fetchJournalWorkouts() {
    // TODO: implement fetchJournalWorkouts
    throw UnimplementedError();
  }

  @override
  String get name => "Local workouts SQLite database";

  @override
  Future<void> updateWorkout(
      String? title, int? weekday, List<ExerciseEntity>? exercises, int index) {
    // TODO: implement updateWorkout
    throw UnimplementedError();
  }

  Database? _database;

  @override
  Future<void> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, AppConsts.workoutsLocalDatabase);

    _database = await openDatabase(path, version: 1,
        onCreate: (database, version) async {
      await database.execute('''CREATE TABLE ${AppConsts.workoutsTable}
      (${AppConsts.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${AppConsts.titleColumn} TEXT NOT NULL,
      ${AppConsts.weekdayColumn} INTEGER NOT NULL,
      ${AppConsts.dateColumn} INTEGER,
      ${AppConsts.durationColumn} INTEGER)
    ''');

      await database.execute('''CREATE TABLE ${AppConsts.exercisesTable}
      (${AppConsts.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${AppConsts.titleColumn} TEXT NOT NULL,
      ${AppConsts.repsColumn} INTEGER,
      ${AppConsts.setsColumn} INTEGER,
      ${AppConsts.weightColumn} REAL, 
      ${AppConsts.exerciseTimeMinutesColumn} INTEGER,
      ${AppConsts.exerciseTimeSecondsColumn} INTEGER,
      ${AppConsts.restTimeMinutesColumn} INTEGER,
      ${AppConsts.restTimeSecondsColumn} INTEGER,
      ${AppConsts.isExercise} INTEGER,
      ${AppConsts.isTimerExercise} INTEGER)
    ''');
    });
  }
}
