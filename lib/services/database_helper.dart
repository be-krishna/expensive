import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/expense.dart';

class DatabaseHelper {
  static const _databaseName = 'ExpenseDatabase.db';
  static const _databaseVersion = 1;

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    // print(dbPath);
    return await openDatabase(
      dbPath,
      version: _databaseVersion,
      onCreate: _onCreateDB,
    );
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${Expense.tblExpense}(
      ${Expense.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Expense.colAmt} REAL NOT NULL,
      ${Expense.colDate} STRING NOT NULL,
      ${Expense.colTime} STRING NOT NULL,
      ${Expense.colNote} STRING NOT NULL,
      ${Expense.colCat} INTEGER NOT NULL
    )
    ''');
  }

  Future<int> insertExpense(Expense expense) async {
    Database db = await database;
    return await db.insert(Expense.tblExpense, expense.toMap());
  }

  Future<int> updateExpense(Expense expense) async {
    Database db = await database;
    return await db.update(
      Expense.tblExpense,
      expense.toMap(),
      where: '${Expense.colId}=?',
      whereArgs: [expense.id],
    );
  }

  Future<int> deleteExpense(int id) async {
    Database db = await database;
    return await db.delete(
      Expense.tblExpense,
      where: '${Expense.colId}=?',
      whereArgs: [id],
    );
  }

  Future<List<Expense>> fetchExpenses() async {
    Database db = await database;
    List<Map> expenses = await db.query(Expense.tblExpense);
    return expenses.length == 0
        ? []
        : expenses.map((e) => Expense.fromMap(e)).toList();
  }

  Future<int> cleanTable() async {
    Database db = await database;
    return db.rawDelete("DELETE FROM ${Expense.tblExpense}");
  }
}
