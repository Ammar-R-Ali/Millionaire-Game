import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  
  static Database? _db;// متغير ثابت لتخزين قاعدة البيانات
  Future<Database?> get db async {//دالة غير متزامنة للوصول إلى قاعدة البيانات
    if (_db == null) {//قاعدة البيانات موجودة
      _db = await _intialDB();//استدعاء دالة لإنشاء قاعدة البيانات
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> _intialDB() async {//دالة غير متزامنة لإنشاء قاعدة البيانات
    String databasepath = await getDatabasesPath();//استدعاء مسار قاعدة البيانات
    String path = join(databasepath, 'game.db');//تكوين مسار قاعدة البيانات
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);//فتح قاعدة البياناتمع استدعاء دوال إنشائ أو ترقية
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    print("onUpgrade ============================");
  }

  Future<void> _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
      CREATE TABLE "easyQuestions" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "question" TEXT NOT NULL,
        "answerT" TEXT NOT NULL,
        "answer1F" TEXT NOT NULL,
        "answer2F" TEXT NOT NULL,
        "answer3F" TEXT NOT NULL
      )
    ''');
    batch.execute('''
      CREATE TABLE "mediumQuestions" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "question" TEXT NOT NULL,
        "answerT" TEXT NOT NULL,
        "answer1F" TEXT NOT NULL,
        "answer2F" TEXT NOT NULL,
        "answer3F" TEXT NOT NULL
      )
    ''');
    batch.execute('''
      CREATE TABLE "hardQuestions" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "question" TEXT NOT NULL,
        "answerT" TEXT NOT NULL,
        "answer1F" TEXT NOT NULL,
        "answer2F" TEXT NOT NULL,
        "answer3F" TEXT NOT NULL
      )
    ''');
    batch.execute('''
      CREATE TABLE "players" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "f_name" TEXT NOT NULL,
        "l_name" TEXT NOT NULL,
        "gain" INTEGER
      )
    ''');

    await batch.commit();
    print("onCreate ================================");

    // تطبيق البيانات الأولية
    await _applyInitialData(db);
  }

  Future<void> _applyInitialData(Database db) async {
    // تحميل ملف SQL من الأصول
    String sql = await rootBundle.loadString('assets/initial_data.sql');

    // تقسيم محتوى الملف إلى أوامر فردية
    List<String> sqlCommands = sql.split(';');

    // تنفيذ الأوامر واحدًا تلو الآخر
    for (var command in sqlCommands) {
      if (command.trim().isNotEmpty) {
        await db.execute(command);
      }
    }
  }

  Future<List<Map<String, Object?>>> readData(String sql) async {
    Database? mydb = await db;
    List<Map<String, Object?>> response = await mydb!.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  Future<void> mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'game.db');
    await deleteDatabase(path);
  }

  Future<void> resetDatabase() async {
    await mydeleteDatabase(); // حذف قاعدة البيانات
    _db = await _intialDB(); // إعادة تهيئة قاعدة البيانات مع البيانات الافتراضية
  }


  Future<List<Map<String, Object?>>> read(String table) async {
    Database? mydb = await db;
    List<Map<String, Object?>> response = await mydb!.query(table);
    return response;
  }

  Future<int> insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

  Future<int> update(String table, Map<String, Object?> value, String? myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, value, where: myWhere);
    return response;
  }

  Future<int> delete(String table, String? myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: myWhere);
    return response;
  }

  Future<int> deleteTable(String table) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table);
    return response;
  }
}