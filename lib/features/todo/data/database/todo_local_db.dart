import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/todo.dart';
import '../models/todo_model.dart';

abstract class TodoLocalDataBase {
  Future<sql.Database> openDB();
  Future<void> createTables(sql.Database database);
  Future<List<Todo>> getTodos();
  Future<Todo> getTodo(int id);
  Future<int> addTodo(TodoModel todo);
  Future<int> updateTodo(TodoModel todo);
  Future<bool> updateTodoStatus(int id, bool isDone);
  Future<void> deleteTodo(int id);
}

class TodoLocalDataBaseImpl implements TodoLocalDataBase {
  @override
  Future<void> createTables(sql.Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        dueDate TIMESTAMP,
        isDone INTEGER NOT NULL DEFAULT 0,
        category_id INTEGER NOT NULL DEFAULT 1
      )
    ''');
  }

  @override
  Future<sql.Database> openDB() async {
    try {
      final db = await sql.openDatabase(
        'todos.db',
        version: 1,
        onCreate: (db, version) async {
          await createTables(db);
        },
      );
      return db;
    } catch (e) {
      throw Exception("Error opening the database: $e");
    }
  }

  @override
  Future<int> addTodo(TodoModel todo) async {
    // print(
    // 'before await: ${todo.title} ${todo.description} ${todo.dueDate} ${todo.categoryId} ${todo.isDone}${todo.id}}');
    try {
      final db = await openDB();
      final data = {
        'title': todo.title,
        'description': todo.description,
        'dueDate': todo.dueDate?.toUtc().toIso8601String(),
        'createdAt': DateTime.now().toUtc().toIso8601String(),
        'isDone': todo.isDone ? 1 : 0,
        'category_id': todo.categoryId.toString(),
      };
      debugPrint("data: $data");
      final id = await db.insert(
        'todos',
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
      await db.close();
      debugPrint("Todo added with ID: $id");
      return id;
    } catch (e) {
      debugPrint("Error adding todo: $e");
      rethrow;
    }
  }
  // get old category id from task id then compare it to new if changed update it
  // final oldTodo = await getTodo(
  //   int.parse(todo.id),
  // );
  // if (oldTodo.categoryId != todo.categoryId) {
  //   data['category_id'] = todo.categoryId.toString();
  // }

  @override
  Future<List<Todo>> getTodos() async {
    final db = await openDB();

    final items = await db.query('todos', orderBy: 'id DESC');
    await db.close();
    print("items: $items");
    //return todos;
    return items.map((item) => TodoModel.fromJson(item).toEntity()).toList();
    // Convert TodoModel to Todo entity and int id to String
    // final todos = items.map((item) {
    // final Todo todo = TodoModel.fromJson(item).toEntity();
    // return todo;
    // }).toList();
    // print("--------------------------------------------- $todos");
    // return todos;
  }

  @override
  Future<Todo> getTodo(int id) async {
    final db = await openDB();

    final item = await db.query(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    await db.close();
    // Convert TodoModel to Todo entity
    final Todo todo = TodoModel.fromJson(item.first).toEntity();
    return todo;
  }

  @override
  Future<int> updateTodo(TodoModel todo) async {
    final db = await openDB();

    final data = {
      'title': todo.title,
      'description': todo.description,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
      'dueDate': todo.dueDate?.toUtc().toIso8601String(),
    };

    data['category_id'] = todo.categoryId.toString();

    final result = await db.update(
      'todos',
      data,
      where: 'id = ?',
      whereArgs: [todo.id],
    );

    await db.close();
    return result;
  }

  @override
  Future<bool> updateTodoStatus(int id, bool isDone) async {
    final db = await openDB();

    final data = {
      'isDone': isDone ? 1 : 0,
    };

    final result = await db.update(
      'todos',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );

    await db.close();
    return result == 1;
  }

  @override
  Future<void> deleteTodo(int id) async {
    final db = await openDB();

    try {
      await db.delete(
        'todos',
        where: 'id = ?',
        whereArgs: [id],
      );
      await db.close();
    } on Exception catch (e) {
      debugPrint("Something went wrong: $e");
    }
  }
}

final todoLocalDataBaseProvider = Provider<TodoLocalDataBaseImpl>(
  (ref) => TodoLocalDataBaseImpl(),
);
