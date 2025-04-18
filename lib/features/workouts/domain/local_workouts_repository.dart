import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class LocalDatabase {
  String get name;

  Future<Database> getDatabase();
  Future<void> initDatabase();
}
