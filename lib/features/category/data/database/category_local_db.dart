import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:uuid/uuid.dart'; // Import the UUID package

import '../../domain/entities/category.dart';
import '../models/category_model.dart';

abstract class CategoryLocalDataBase {
  Future<sql.Database> openDB();
  Future<void> createTables(sql.Database database);
  Future<List<Category>> getCategories();
  Future<Category> getCategory(String id);
  Future<void> addCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(String id);
}

class CategoryLocalDataBaseImpl implements CategoryLocalDataBase {
  final Uuid uuid = const Uuid(); // Create a UUID generator instance

  @override
  Future<sql.Database> openDB() async {
    try {
      final dbPath = await sql.getDatabasesPath();
      return sql.openDatabase(
        '$dbPath/categories.db',
        onCreate: (db, version) async {
          await createTables(db);
        },
        version: 1,
      );
    } on Exception catch (e) {
      throw Exception("Error opening the database: $e");
    }
  }

  @override
  Future<void> createTables(sql.Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS categories (
        id TEXT PRIMARY KEY NOT NULL,
        name TEXT,
        iconIndex INTEGER,
        colorIndex INTEGER
      )
    ''');

    final List<Map<String, dynamic>> maps = await database.query('categories');
    if (maps.isEmpty) {
      print('Inserting some raw data into the categories table...');
      final List<CategoryModel> categories = [
        CategoryModel(
          id: uuid.v4(),
          name: 'General',
          iconIndex: 17,
          colorIndex: 7,
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Design',
          iconIndex: 0,
          colorIndex: 0,
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Code',
          iconIndex: 1,
          colorIndex: 1,
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Meeting',
          iconIndex: 2,
          colorIndex: 2,
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Shopping',
          iconIndex: 3,
          colorIndex: 3,
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Travel',
          iconIndex: 4,
          colorIndex: 4,
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Study',
          iconIndex: 5,
          colorIndex: 5,
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Work',
          iconIndex: 6,
          colorIndex: 6,
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Home',
          iconIndex: 7,
          colorIndex: 7,
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Health',
          iconIndex: 8,
          colorIndex: 8,
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Food',
          iconIndex: 9,
          colorIndex: 9,
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Other',
          iconIndex: 10,
          colorIndex: 10,
        )
      ];

      for (var category in categories) {
        await database.insert(
          'categories',
          category.toMap(),
          conflictAlgorithm: sql.ConflictAlgorithm.replace,
        );
        print('===============================CATEGORY ID');
        print(
            '${category.id} ${category.name} ${category.iconIndex} ${category.colorIndex}');
        print('...Done');
      }
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    final db = await openDB();
    try {
      final List<Map<String, dynamic>> maps = await db.query('categories');
      print('===============================CATEGORY ID');
      print(maps);
      return List.generate(maps.length, (i) {
        return CategoryModel(
          id: maps[i]['id'].toString(),
          name: maps[i]['name'],
          iconIndex: maps[i]['iconIndex'],
          colorIndex: maps[i]['colorIndex'],
        );
      });
    } catch (e) {
      throw Exception("Error getting categories: $e");
    } finally {
      await db.close();
    }
  }

  @override
  Future<Category> getCategory(String id) async {
    final db = await openDB();
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'categories',
        where: 'id = ?',
        whereArgs: [id],
      );
      return CategoryModel(
        id: maps.first['id'].toString(),
        name: maps.first['name'],
        iconIndex: maps.first['iconIndex'],
        colorIndex: maps.first['colorIndex'],
      );
    } catch (e) {
      throw Exception("Error getting category: $e");
    } finally {
      await db.close();
    }
  }

  @override
  Future<void> addCategory(Category category) async {
    print('addCategory: ${category.id}');
    final db = await openDB();
    await db.insert(
      'categories',
      CategoryModel(
        id: uuid.v4(),
        name: category.name,
        iconIndex: category.iconIndex,
        colorIndex: category.colorIndex,
      ).toMap(),
      // conflictAlgorithm: sql.
    );
  }

  @override
  Future<void> updateCategory(Category category) async {
    final db = await openDB();
    await db.update(
      'categories',
      CategoryModel(
        id: category.id,
        name: category.name,
        iconIndex: category.iconIndex,
        colorIndex: category.colorIndex,
      ).toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  @override
  Future<void> deleteCategory(String id) async {
    final db = await openDB();
    await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// categoryLocalDataBaseProvider

final categoryLocalDataBaseProvider = Provider<CategoryLocalDataBase>(
  (ref) => CategoryLocalDataBaseImpl(),
);
