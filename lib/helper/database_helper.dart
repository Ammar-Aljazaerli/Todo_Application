import 'dart:convert';
import 'dart:io';

import 'package:TODO_APPLICATION/models/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;
  static String KDbDatabaseName = 'task_list.db';
  DatabaseHelper._instance();

  String taskTable = 'task_table';
  String coId = 'id';
  String coTitle = 'title';
  String coDate = 'date';
  String coPrioirty = 'prioirty';
  String coStatus = 'status';

  Future<Database> get db async {
    if (_db == null) _db = await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + KDbDatabaseName;
    final todoListDb =
        await openDatabase(path, version: 1, onCreate: _onCreate);
    return todoListDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $taskTable($coId INTEGER PRIMARY KEY AUTOINCREMENT,$coTitle TEXT,$coDate TEXT,$coPrioirty TEXT,$coStatus INTEGER)',
    );
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(taskTable);
    return result;
  }

  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });
    return taskList;
  }

  Future<int> insertTask(Task task) async {
    Database db = await this.db;
    final int result = await db.insert(taskTable, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    Database db = await this.db;
    final int result = await db.update(
      taskTable,
      task.toMap(),
      where: '$coId=?',
      whereArgs: [task.id],
    );
    return result;
  }

  Future<int> deleteTask(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      taskTable,
      where: '$coId=?',
      whereArgs: [id],
    );
    return result;
  }
}
