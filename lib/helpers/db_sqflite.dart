import 'dart:io';

import 'package:furtime/models/pet_model.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task_model.dart';

class DatabaseHelper {
  static DatabaseHelper instance = DatabaseHelper();

  Future<Database> get database async {
    final db = await _initDB();
    return db;
  }

  var dbName = 'furTimeDatabase.db';
  int version = 1;
  String myPetsTable = 'mypets';

  String id = 'id';
  String fullname = 'fullname';
  String age = 'age';
  String breed = 'breed';
  String gender = 'gender';
  String imagePath = 'image_path';

  //

  String myTodosTable = 'todos';

  String todoId = 'id';
  String todoTitle = 'title';
  String todoDescription = 'description';
  String todoDate = 'date';
  String todoTime = 'time';
  String todoIsCompleted = 'is_completed';
  String hasReminder = 'has_reminder';

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    // deleteDatabase(path);
    return await openDatabase(
      path,
      version: version,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    try {
      await db.execute('''
      CREATE TABLE $myPetsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        $fullname TEXT NOT NULL,
        $age INTEGER NOT NULL,
        $breed TEXT NOT NULL,
        $gender TEXT NOT NULL,
        $imagePath TEXT
      )
    ''');
      print('Table $myPetsTable created successfully.');

      await db.execute('''
      CREATE TABLE $myTodosTable (
        $todoId INTEGER PRIMARY KEY AUTOINCREMENT,
        $todoTitle TEXT NOT NULL,
        $todoDescription TEXT NOT NULL,
        $todoDate TEXT NOT NULL,
        $todoTime TEXT NOT NULL,
        $todoIsCompleted INTEGER NOT NULL,
        $hasReminder INTEGER NOT NULL
      )
    ''');
      print('Table $myTodosTable created successfully.');
    } catch (e) {
      print('Error creating database: $e');
    }
  }

  Future close() async {
    final db = await database;
    db.close();
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert(myPetsTable, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await database;
    var data = await db.query('$myPetsTable ORDER BY id DESC');
    ALL_PET_DATA.value = PetModel.fromListJson(data);
    return data;
  }

  Future<String> saveImageToFolder(XFile imageFile, String newFileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final targetFolder = "${directory.path}/MyPetImages";

    var file = File(imageFile.path);
    // Ensure the target folder exists
    final folder = Directory(targetFolder);
    if (!folder.existsSync()) {
      folder.createSync(recursive: true);
    }

    // Define the new file path
    final newFilePath = join(targetFolder, newFileName);

    // Copy the file to the target folder
    final copiedFile = await file.copy(newFilePath);

    return copiedFile.path;
  }

//
  Future<int> insertTodo(Map<String, dynamic> row) async {
    print(row.toString());
    final db = await database;
    return await db.insert(myTodosTable, row);
  }

  Future<List<Map<String, dynamic>>> queryAllTodoRows() async {
    ALL_TODO_DATA.value = [];
    final db = await database;
    var data = await db.query('$myTodosTable ORDER BY id DESC');
    ALL_TODO_DATA.value = TaskModel.fromListJson(data);
    return data;
  }

  Future<int> updateTodo(Map<String, dynamic> row) async {
    print(row.toString());
    int result = 0;
    try {
      final db = await database;
      result = await db.update(
          myTodosTable,
          {
            todoTitle: row[todoTitle],
            todoDescription: row[todoDescription],
            todoDate: row[todoDate],
            todoTime: row[todoTime],
            todoIsCompleted: row[todoIsCompleted],
            hasReminder: row[hasReminder],
          },
          where: '$todoId = ?',
          whereArgs: [row[todoId]]);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete(myTodosTable, where: '$todoId = ?', whereArgs: [id]);
  }
}
