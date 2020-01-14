import 'dart:async';

import 'package:obs_gyn/PatientDetails.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableNote = 'PatientList';
  final String columnId = 'patient_id';
  final String columnLMP = 'LMP';
  final String columnNotes = 'notes';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'PatientList.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tableNote('
        '$columnId INTEGER PRIMARY KEY, '
        '$columnLMP TEXT, '
        '$columnNotes TEXT)');
  }

  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient
        .query(tableNote, columns: [columnId, columnLMP, columnNotes]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');

    return result.toList();
  }

  Future<int> saveNote(PatientDetails note) async {
    var dbClient = await db;
    return await dbClient.insert(tableNote, note.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');

    //return result;
  }

  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableNote, where: '$columnId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    var dbClient = await db;
    return await dbClient.query(tableNote);
  }
}
