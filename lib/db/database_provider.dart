import 'package:path/path.dart';
import 'package:raynotes/model/note_model.dart';
import 'package:raynotes/screens/display_notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
        onCreate: ((db, version) async {
      await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            body TEXT,
            creation_date DATE
          )
          ''');
    }), version: 1);
  }

  addNewNote(NoteModel note) async {
    final db = await database;
    db?.insert("notes", note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> getNotes() async {
    final db = await database;
    var res = await db?.query("notes");
    if (res?.length == 0) {
      return Null;
    } else {
      var resultMap = res?.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    int count = await db.rawDelete("DELETE FROM notes WHERE id = ?", [id]);
    return count;
  }

  Future<int> updateNote(ShowNote note) async {
    final db = await database;
    int count = await db.rawUpdate("UPDATE FROM notes WHERE id = ?", [note]);
  }
}
