
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/database_helper.dart';
import 'expense.dart';

class ExpenseData extends ChangeNotifier {
  DatabaseHelper _dbHelper;
  ExpenseData() {
    _dbHelper = DatabaseHelper.instance;
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

  set setExpenses(List<Expense> expenses) => _expenses = expenses;

  // Future<String> getJson() {
  //   return rootBundle.loadString('assets/expense.json');
  // }

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

  void addDataToList() async {
    // final List parsed = json.decode(await getJson());

    // List<Expense> list = parsed.map((e) => Expense.fromJson(e)).toList();

    List<Expense> list = await _dbHelper.fetchExpenses();

    _expenses = list;
    notifyListeners();
  }

  void addExpense({date, time, amount, category, note}) {
    Expense newExpense = Expense(
      amount: amount,
      category: category,
      date: date,
      note: note,
      time: time,
    );

    _expenses.add(newExpense);
    notifyListeners();
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
