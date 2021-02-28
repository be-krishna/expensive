import 'dart:convert';
import 'dart:io';

import 'package:expensive/models/deleted_expense_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/database_helper.dart';
import '../services/file_handler.dart';
import 'expense.dart';

class ExpenseData extends ChangeNotifier {
  DatabaseHelper _dbHelper;
  DeletedExpenseData deletedExpenseData;
  ExpenseData() {
    _dbHelper = DatabaseHelper.instance;
    deletedExpenseData = DeletedExpenseData();
    _firstRun();
    addDataToList();
    notifyListeners();
  }
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  double get total => totalExpense();

  double get totalOnEdu => totalExpenseByCategory(ExpenseCategory.EDUCATION);
  double get totalOnEnt =>
      totalExpenseByCategory(ExpenseCategory.ENTERTAINMENT);
  double get totalOnFood => totalExpenseByCategory(ExpenseCategory.FOOD);
  double get totalOnOthers => totalExpenseByCategory(ExpenseCategory.OTHERS);
  double get totalOnShop => totalExpenseByCategory(ExpenseCategory.SHOPPING);
  double get totalOnTrans => totalExpenseByCategory(ExpenseCategory.TRANSPORT);
  double get totalOfWeek => _amountOfWeek();
  double get totalOfMonth => _amountOfMonth();
  double get totalOfYear => _amountOfYear();
  double get totalOfDay => _amountOfDay();
  Expense get latestExpense => sortedExpenses().first;

  void get refreshList => _refreshExpenseList();

  Future<String> getJson() {
    return rootBundle.loadString('assets/expense.json');
  }

  void _firstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _firstRun = prefs.getBool('_firstRun') ?? true;
    if (_firstRun) {
      _dbHelper.insertExpense(
        Expense(
          amount: 500,
          category: ExpenseCategory.FOOD,
          date: DateTime.now(),
          time: TimeOfDay(hour: 10, minute: 12),
          note: "Example title",
        ),
      );
      await prefs.setBool('_firstRun', false);
    }
  }

  Future<bool> importFromJson() async {
    List parsed;
    try {
      parsed = json.decode(await FileHandler.readFromFile());
      List<Expense> list = parsed.map((e) => Expense.fromMap(e)).toList();

      list.forEach((element) => _dbHelper.insertExpense(element));
      _refreshExpenseList();
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<String> exportToJson() async {
    try {
      List<Expense> exp = await _dbHelper.fetchExpenses();
      String jsonData = jsonEncode(exp);
      File file = await FileHandler.writeToFile(jsonData);
      return file.path;
    } catch (e) {
      print(e.toString());
      return "Export Error";
    }
  }

  void clearTable() async {
    await _dbHelper.cleanTable();
    _refreshExpenseList();
    notifyListeners();
  }

  void addDataToList() async {
    List<Expense> list = await _dbHelper.fetchExpenses();

    _expenses = list;
    notifyListeners();
  }

  void _refreshExpenseList() async {
    _expenses = await _dbHelper.fetchExpenses();
    notifyListeners();
  }

  void addExpense({
    DateTime date,
    TimeOfDay time,
    double amount,
    ExpenseCategory category,
    String note,
  }) {
    Expense newExpense = Expense(
      amount: amount,
      category: category,
      date: date,
      note: note,
      time: time,
    );

    _dbHelper.insertExpense(newExpense);
    _refreshExpenseList();
    notifyListeners();
  }

  void deleteExpense(int id) async {
    Expense deletedExpense = await _dbHelper.getExpenseById(id);
    deletedExpenseData.addExpense(deletedExpense);
    await _dbHelper.deleteExpense(id);
    _refreshExpenseList();
  }

  void updatExpense(Expense expense) async {
    await _dbHelper.updateExpense(expense);
    _refreshExpenseList();
  }

  List<Expense> sortedExpenses({List<Expense> customList}) {
    List<Expense> temp = customList ?? _expenses;
    temp.sort((a, b) => a.compareTo(b));
    return temp;
  }

  double totalExpense() {
    if (_expenses.isEmpty) addDataToList();
    double totalAmount = 0;

    expenses.forEach((element) {
      totalAmount += element.amount;
    });

    return totalAmount;
  }

  double totalExpenseByCategory(ExpenseCategory category,
      [List<Expense> expense]) {
    if (_expenses.isEmpty) addDataToList();
    double totalAmount = 0;
    var list = expense ?? _expenses;

    list.forEach((element) {
      if (element.category == category) {
        totalAmount += element.amount;
      }
    });

    return totalAmount;
  }

  List<Expense> expensesOfYear() {
    if (_expenses.isEmpty) addDataToList();
    List<Expense> yearlyExpense = [];

    _expenses.forEach((element) {
      if (element.date.year == DateTime.now().year) {
        yearlyExpense.add(element);
      }
    });

    return yearlyExpense;
  }

  double _amountOfYear() {
    List<Expense> _list = expensesOfYear();

    double sum = 0;

    _list.forEach((element) {
      sum += element.amount;
    });

    return sum;
  }

  List<Expense> expensesOfMonth() {
    if (_expenses.isEmpty) addDataToList();
    List<Expense> monthlyExpense = [];

    _expenses.forEach((element) {
      if (element.date.month == DateTime.now().month) {
        monthlyExpense.add(element);
      }
    });

    return monthlyExpense;
  }

  double _amountOfMonth() {
    List<Expense> _list = expensesOfMonth();

    double sum = 0;

    _list.forEach((element) {
      sum += element.amount;
    });

    return sum;
  }

  List<Expense> expensesOfWeek() {
    if (_expenses.isEmpty) addDataToList();
    List<Expense> weeklyExpense = [];

    _expenses.forEach((element) {
      if (element.date.isAfter(DateTime.now().subtract(Duration(days: 7)))) {
        weeklyExpense.add(element);
      }
    });

    return weeklyExpense;
  }

  double _amountOfWeek() {
    List<Expense> _list = expensesOfWeek();

    double sum = 0;

    _list.forEach((element) {
      sum += element.amount;
    });

    return sum;
  }

  List<Expense> expensesOfDay() {
    if (_expenses.isEmpty) addDataToList();
    List<Expense> dailyExpense = [];

    _expenses.forEach((element) {
      if (element.date.day == DateTime.now().day) {
        dailyExpense.add(element);
      }
    });

    return dailyExpense;
  }

  double _amountOfDay() {
    List<Expense> _list = expensesOfDay();

    double sum = 0;

    _list.forEach((element) {
      sum += element.amount;
    });

    return sum;
  }

  void printExpenses({List<Expense> expense}) {
    if (_expenses.isEmpty) addDataToList();
    var list = expense ?? _expenses;
    list.forEach((element) => print(element));
  }
}
