import 'package:sqflite/sqflite.dart';

abstract interface class LocalDatabase {
  String get name;

  Future<Database> getDatabase();
  Future<void> initDatabase();
}
