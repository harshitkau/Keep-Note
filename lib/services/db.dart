import 'dart:convert';

import 'package:keep_note/model/my_note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;
  NotesDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initilizeDB('NewNotes.db');
    return _database;
  }

  Future<Database> _initilizeDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final boolType = "BOOLEAN NOT NULL";
    final textType = "TEXT NOT NULL";
    await db.execute('''
      CREATE TABLE Notes(
        ${NotesImpNames.id} $idType,
        ${NotesImpNames.pin} $boolType,
        ${NotesImpNames.isArchive} $boolType,
        ${NotesImpNames.title} $textType,
        ${NotesImpNames.content} $textType,
        ${NotesImpNames.createdTime} $textType  
      ) 
    ''');
  }

  Future<Note?> InsertEntry(Note note) async {
    final db = await instance.database;
    final id = await db!.insert(NotesImpNames.TableName, note.toJson());
    return note.copy(id: id);
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = '${NotesImpNames.createdTime} DESC';
    final query_result =
        await db!.query(NotesImpNames.TableName, orderBy: orderBy);
    return query_result.map((json) => Note.fromJson(json)).toList();
  }

  Future<List<Note>> readAllArchiveNotes() async {
    final db = await instance.database;
    final orderBy = '${NotesImpNames.createdTime} DESC';
    final query_result = await db!.query(NotesImpNames.TableName,
        orderBy: orderBy, where: '${NotesImpNames.isArchive}=1');
    return query_result.map((json) => Note.fromJson(json)).toList();
  }

  Future<List<Note>> readAllPinNotes() async {
    final db = await instance.database;
    final orderBy = '${NotesImpNames.createdTime} DESC';
    final query_result = await db!.query(NotesImpNames.TableName,
        orderBy: orderBy, where: '${NotesImpNames.pin}=1');
    return query_result.map((json) => Note.fromJson(json)).toList();
  }

  Future<Note?> readOneNote(int id) async {
    final db = await instance.database;
    final map = await db!.query(NotesImpNames.TableName,
        columns: NotesImpNames.values,
        where: "${NotesImpNames.id}=?",
        whereArgs: [id]);

    if (map.isNotEmpty) {
      return Note.fromJson(map.first);
    } else {
      return null;
    }
  }

  Future<List<int>> getNoteString(String query) async {
    final db = await instance.database;
    final result = await db!.query(NotesImpNames.TableName);
    List<int> resultIds = [];
    result.forEach((element) {
      if (element["title"].toString().toLowerCase().contains(query) ||
          element["content"].toString().toLowerCase().contains(query)) {
        resultIds.add(element["id"] as int);
      }
    });
    return resultIds;
  }

  Future updateNotes(Note note) async {
    final db = await instance.database;
    return await db!.update(
      NotesImpNames.TableName,
      note.toJson(),
      where: "${NotesImpNames.id}=?",
      whereArgs: [note.id],
    );
  }

  Future pinNote(Note? note) async {
    final db = await instance.database;
    return await db!.update(
      NotesImpNames.TableName,
      {NotesImpNames.pin: !note!.pin ? 1 : 0},
      where: "${NotesImpNames.id}=?",
      whereArgs: [note.id],
    );
  }

  Future archNote(Note? note) async {
    final db = await instance.database;
    return await db!.update(
      NotesImpNames.TableName,
      {NotesImpNames.isArchive: !note!.isArchive ? 1 : 0},
      where: "${NotesImpNames.id}=?",
      whereArgs: [note.id],
    );
  }

  Future deleteNotes(Note note) async {
    final db = await instance.database;
    await db!.delete(
      NotesImpNames.TableName,
      where: "${NotesImpNames.id}=?",
      whereArgs: [note.id],
    );
  }

  Future closeDB() async {
    final db = await instance.database;
    db!.close();
  }
}
