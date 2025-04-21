import 'package:body_buddies/features/workouts/domain/local_workouts_repository.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WorkoutsSQLiteLocalDatabase implements LocalDatabase {
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
      ${AppConsts.weekdayColumn} INTEGER NOT NULL)
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
      ${AppConsts.isTimerExercise} INTEGER,
      ${AppConsts.workoutIdColumn} INTEGER)
    ''');

      await database.execute('''CREATE TABLE ${AppConsts.journalTable}
      (${AppConsts.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${AppConsts.titleColumn} TEXT NOT NULL,
      ${AppConsts.weekdayColumn} INTEGER NOT NULL,
      ${AppConsts.dateColumn} INTEGER,
      ${AppConsts.durationColumn} INTEGER)
    ''');

      await database.execute('''CREATE TABLE ${AppConsts.journalExercisesTable}
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
      ${AppConsts.isTimerExercise} INTEGER,
      ${AppConsts.workoutIdColumn} INTEGER)
    ''');
    });
  }

  @override
  String get name => "Workouts local SQLite database";
}
