import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;

// import '../../../../core/errors/errors.dart';
import '../../domain/entities/category.dart';
import '../models/category_model.dart';

abstract class CategoryLocalDataBase {
  Future<sql.Database> openDB();
  Future<void> createTables(sql.Database database);
  Future<List<Category>> getCategories();
  Future<Category> getCategory(int id);
  Future<int> addCategory(Category category);
  Future<int> updateCategory(Category category);
  Future<void> deleteCategory(int id);
}
//sqlite is local database

class CategoryLocalDataBaseImpl implements CategoryLocalDataBase {
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

  //Create table and fill it with some predefined data
  @override
  Future<void> createTables(sql.Database database) async {
    //create if not exists
    await database.execute('''
    CREATE TABLE IF NOT EXISTS categories (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      iconIndex INTEGER,
      colorIndex INTEGER
    )
  ''');

    //insert some data if table is empty
    final List<Map<String, dynamic>> maps = await database.query('categories');
    if (maps.isEmpty) {
      print('Inserting some raw data into the categories table...');
      final List<CategoryModel> categories = [
        CategoryModel(
          id: '1',
          name: 'Design',
          iconIndex: 0,
          colorIndex: 0,
        ),
        CategoryModel(
          id: '2',
          name: 'Code',
          iconIndex: 1,
          colorIndex: 1,
        ),
        CategoryModel(
          id: '3',
          name: 'Meeting',
          iconIndex: 2,
          colorIndex: 2,
        ),
        CategoryModel(
          id: '4',
          name: 'Shopping',
          iconIndex: 3,
          colorIndex: 3,
        ),
        CategoryModel(
          id: '5',
          name: 'Travel',
          iconIndex: 4,
          colorIndex: 4,
        ),
        CategoryModel(
          id: '6',
          name: 'Study',
          iconIndex: 5,
          colorIndex: 5,
        ),
        CategoryModel(
          id: '7',
          name: 'Work',
          iconIndex: 6,
          colorIndex: 6,
        ),
        CategoryModel(
          id: '8',
          name: 'Home',
          iconIndex: 7,
          colorIndex: 7,
        ),
        CategoryModel(
          id: '9',
          name: 'Health',
          iconIndex: 8,
          colorIndex: 8,
        ),
        CategoryModel(
          id: '10',
          name: 'Food',
          iconIndex: 9,
          colorIndex: 9,
        ),
        CategoryModel(
          id: '11',
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
        print('...Done');
      }
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    final db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return List.generate(maps.length, (i) {
      return CategoryModel(
        id: maps[i]['id'].toString(),
        name: maps[i]['name'],
        iconIndex: maps[i]['iconIndex'],
        colorIndex: maps[i]['colorIndex'],
      );
    });
  }

  @override
  Future<Category> getCategory(int id) async {
    final db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
    return CategoryModel(
      id: maps[0]['id'].toString(),
      name: maps[0]['name'],
      iconIndex: maps[0]['iconIndex'],
      colorIndex: maps[0]['colorIndex'],
    );
  }

  @override
  Future<int> addCategory(Category category) async {
    final db = await openDB();
    return await db.insert(
      'categories',
      CategoryModel(
        id: category.id,
        name: category.name,
        iconIndex: category.iconIndex,
        colorIndex: category.colorIndex,
      ).toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> updateCategory(Category category) async {
    final db = await openDB();
    return await db.update(
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
  Future<void> deleteCategory(int id) async {
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
