import 'package:body_buddies/features/useful/domain/entity/advice_entity.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalUsefulSqlDatabase implements UsefulRepository {
  Database? _database;

  Future<Database> getDatabase() async {
    if (_database == null) {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, AppConsts.usefulLocalDatabase);

      _database = await openDatabase(path, version: 1,
          onCreate: (database, version) async {
        await database.execute('''CREATE TABLE ${AppConsts.advicesTable}
        (${AppConsts.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${AppConsts.titleColumn} TEXT NOT NULL,
        ${AppConsts.bodyColumn} TEXT NOT NULL)''');
      });
    }

    return _database!;
  }

  @override
  Future<List<AdviceEntity>> fetchAdvices(String token) async {
    final database = await getDatabase();
    final response = await database.query(AppConsts.advicesTable);

    final advices = response
        .map((adviceMap) => AdviceEntity(
            title: adviceMap['title'].toString(),
            bodyText: adviceMap['body'].toString()))
        .toList();

    return advices;
  }

  @override
  Future<List<ExerciseOnListEntity>> fetchExercises(String token) {
    throw UnimplementedError();
  }

  Future<void> addAdvice(String title, String body) async {
    final database = await getDatabase();

    final response = await database
        .query(AppConsts.advicesTable, where: "title=?", whereArgs: [title]);

    if (response.isEmpty) {
      final adviceMap = <String, dynamic>{'title': title, 'body': body};
      await database.insert(AppConsts.advicesTable, adviceMap);
    }
  }

  @override
  String get name => "Local useful repository";

  @override
  Future<void> addExerciseOnList(String title, bool isExercise) {
    // TODO: implement addExerciseOnList
    throw UnimplementedError();
  }

  @override
  Future<List<WorkoutEntity>> fetchCreatedWorkouts(String token) {
    throw UnimplementedError();
  }
}
