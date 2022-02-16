import 'package:noteplus_demo/model/textNotes.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'list_Data.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String todoTable = 'todo_table';
  String colId = 'id';
  String colTitleText = 'titleText';
  String colNoteText = 'noteText';
  String colDate = 'date';
  String colTime = 'time';

  String listTodoTable = 'list_Todo_Table';
  String listColId = 'listNoteId';
  String listColNoteText = 'textFieldText';
  String listColCheck = 'checkVal';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'todos.db';

    var todosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitleText TEXT, '
        '$colNoteText TEXT, $colDate TEXT, $colTime TEXT)');
    await db.execute(
        'CREATE TABLE $listTodoTable($colId INTEGER, $listColId INTEGER PRIMARY KEY, '
        '$listColNoteText TEXT, $listColCheck TEXT)');
  }

  //-------------------------
  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await database;
    var result = await db.query(todoTable, orderBy: '$colDate ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getMapListItem() async {
    Database db = await database;
    var result = await db.query(listTodoTable, orderBy: '$listColId ASC');
    return result;
  }

  //-------------------------

//----------------------------------
  Future<int> insertTodo(TextNotes note) async {
    Database db = await database;
    var result = await db.insert(todoTable, note.toMap());
    return result;
  }

  Future<int> insertList(ListItem listItem) async {
    Database db = await database;
    var result = await db.insert(listTodoTable, listItem.toMap());
    return result;
  }

//----------------------------------

//----------------------------------
  Future<int> updateTodo(TextNotes note) async {
    var db = await database;
    var result = await db.update(todoTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> updateList(ListItem listItem) async {
    var db = await database;
    var result = await db.update(listTodoTable, listItem.toMap(),
        where: '$listColId = ?', whereArgs: [listItem.id]);
    return result;
  }

//----------------------------------

//----------------------------------
  Future<int> deleteTodo(int id) async {
    var db = await database;
    int result =
        await db.rawDelete('DELETE FROM $todoTable WHERE $colId = $id');
    return result;
  }

  Future<int> deleteList(int id) async {
    var db = await database;
    int result =
        await db.rawDelete('DELETE FROM $listTodoTable WHERE $listColId = $id');
    return result;
  }

//----------------------------------

//----------------------------------
  Future<int?> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $todoTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

//----------------------------------

//----------------------------------
  Future<List<TextNotes>?> getTodoList() async {
    var todoMapList = await getTodoMapList();
    int count = todoMapList.length;
    print('-------count----$count---');
    List<TextNotes>? notes = [];
    for (int i = 0; i < count; i++) {
      print('------mapData----${todoMapList[i]}====');
      notes.add(TextNotes.fromMap(todoMapList[i]));
    }
    print('----notes----$notes');
    return notes;
  }

  Future<List<ListItem>?> getListItem() async {
    var todoList = await getMapListItem();
    int count = todoList.length;
    print('-------count111----$count---');
    List<ListItem>? notes = [];
    for (int i = 0; i < count; i++) {
      print('------mapData111----${todoList[i]}====');
      notes.add(ListItem.fromMap(todoList[i]));
    }
    print('----notes111----$notes');
    return notes;
  }
//----------------------------------

}
