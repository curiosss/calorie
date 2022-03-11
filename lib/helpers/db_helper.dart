import 'dart:async';
import 'dart:io' show Directory;

import 'package:calorie_calculator/models/category_model.dart';
import 'package:calorie_calculator/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static final DB instance = DB._();
  static Database _database;

  DB._();

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "database.db");

    return await openDatabase(
      path,
      version: 1,
      onOpen: (Database db) {},
      onCreate: _onCreate,
      onUpgrade: _onUpgradeAndDowngrade,
      onDowngrade: _onUpgradeAndDowngrade,
    );
  }

  _onCreate(Database db, int version) async {
    await _createTableCategories(db);
    await _createTableProducts(db);
    await _createTableMenus(db);
  }

  _onUpgradeAndDowngrade(Database db, int oldVersion, int newVersion) async {
    await _createTableCategories(db);
    await _createTableProducts(db);
    await _createTableMenus(db);
  }

  /// Create products table
  Future<void> _createTableCategories(Database db) async {
    await db.execute('DROP TABLE IF EXISTS categories;');
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY,
        title TEXT,
        image TEXT
      );
    ''');
  }

  /// Create cart table
  Future<void> _createTableProducts(Database db) async {
    await db.execute('DROP TABLE IF EXISTS products;');
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY,
        cat_id INTEGER,
        name TEXT,
        calorie INTEGER,
        protein INTEGER,
        fat INTEGER,
        carbohydrate INTEGER,
        image TEXT
      );
    ''');
  }

  Future<void> _createTableMenus(Database db) async {
    await db.execute('DROP TABLE IF EXISTS menus;');
    await db.execute('''
      CREATE TABLE menus (
        id INTEGER PRIMARY KEY,
        date TEXT,
        meals TEXT,
        water REAL,
      );
    ''');
  }

  Future<bool> createCategory(Category category) async {
    final db = await database;
    var batch = db.batch();
    var _categories = await db.rawQuery(
      'SELECT * FROM categories WHERE id=?',
      [category.id],
    );
    if (_categories.isNotEmpty) {
      return false;
    }

    try {
      batch.execute(
        'INSERT OR REPLACE INTO categories VALUES (?, ?, ?)',
        [category.id, category.catName, category.image],
      );
      await batch.commit(noResult: true, continueOnError: false);
      print('successfully inserted to database');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateCategory({Category category}) async {
    try {
      final db = await database;
      await db.rawUpdate(
        'UPDATE categories SET title=?, image=? WHERE id=?',
        [category.catName, category.image, category.id],
      );
      print('true');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteCategory({int catId}) async {
    print('delete cat');
    print(catId);
    try {
      final db = await database;
      await db.rawUpdate(
        'DELETE FROM categories WHERE id=?',
        [catId],
      );
      print('true');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Category>> getCategories() async {
    final db = await database;
    var _categories = await db.rawQuery('SELECT * FROM categories');

    return List.from(
      _categories.map(
        (e) {
          return Category.fromMap(e);
        },
      ),
    );
  }

  //PRODUCTS

  Future<bool> createProduct(Product product) async {
    final db = await database;
    var batch = db.batch();
    var _products = await db.rawQuery(
      'SELECT * FROM products WHERE id=?',
      [product.id],
    );
    if (_products.isNotEmpty) {
      return false;
    }

    try {
      batch.execute(
        'INSERT OR REPLACE INTO products VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [
          product.id,
          product.categoryId,
          product.name,
          product.calorie,
          product.protein,
          product.fat,
          product.carbohydrate,
          product.image,
        ],
      );
      await batch.commit(noResult: true, continueOnError: false);
      print('product successfully inserted to database');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateProduct({Product product}) async {
    try {
      final db = await database;
      await db.rawUpdate(
        'UPDATE products SET cat_id=?, name=?, calorie=?, protein=?, fat=?, carbohydrate=?, image=? WHERE id=?',
        [
          product.categoryId,
          product.name,
          product.calorie,
          product.protein,
          product.fat,
          product.carbohydrate,
          product.image,
          product.id
        ],
      );
      print('true');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteProduct({int productId}) async {
    print('delete product');
    print(productId);
    try {
      final db = await database;
      await db.rawUpdate(
        'DELETE FROM products WHERE id=?',
        [productId],
      );
      print('true');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Product>> getProducts({@required categoryId}) async {
    print('getting product $categoryId');
    final db = await database;
    var _products = await db.rawQuery(
      'SELECT * FROM products WHERE cat_id=?',
      [categoryId],
    );
    print(_products);
    return List.from(
      _products.map(
        (e) {
          return Product.fromMap(e);
        },
      ),
    );
  }

  Future<List<Product>> getAllProducts() async {
    print('getting all products from db');
    final db = await database;
    var _products = await db.rawQuery(
      'SELECT * FROM products',
    );
    print(_products);
    return List.from(
      _products.map(
        (e) {
          return Product.fromMap(e);
        },
      ),
    );
  }
}
