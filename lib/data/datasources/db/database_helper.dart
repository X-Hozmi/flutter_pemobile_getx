import 'dart:async';
import 'package:flutter_pemobile_getx/data/models/person/person_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblPerson = 'tb_person_page';
  String get tblPerson => _tblPerson;

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/pemobile.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblPerson (
        id INTEGER PRIMARY KEY,
        name VARCHAR(255),
        email VARCHAR(255),
        handphone VARCHAR(20),
        address TEXT,
        password VARCHAR(255),
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
      );
    ''');
  }

  Future<int> insertPerson(PersonTable person) async {
    final db = await database;
    return await db!.insert(
      _tblPerson,
      person.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> removePerson(PersonTable person) async {
    final db = await database;
    return await db!.delete(
      _tblPerson,
      where: 'id = ?',
      whereArgs: [person.id],
    );
  }

  Future<Map<String, dynamic>?> getPersonById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblPerson,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getPersons() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblPerson);

    return results;
  }

  void onCreate(Database db, int version) {
    _onCreate(db, version);
  }
}
