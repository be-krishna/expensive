import 'dart:collection';
import 'dart:convert';

import 'expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ExpenseData extends ChangeNotifier {
  ExpenseData() {
    addDataToList();
    notifyListeners();
  }
  List<Expense> _expenses = [];

  UnmodifiableListView<Expense> get expenses => UnmodifiableListView(_expenses);

  double get total => totalExpense();

  double get totalOnEdu => totalExpenseByCategory(ExpenseCategory.EDUCATION);
  double get totalOnEnt =>
      totalExpenseByCategory(ExpenseCategory.ENTERTAINMENT);
  double get totalOnFood => totalExpenseByCategory(ExpenseCategory.FOOD);
  double get totalOnOthers => totalExpenseByCategory(ExpenseCategory.OTHERS);
  double get totalOnShop => totalExpenseByCategory(ExpenseCategory.SHOPPING);
  double get totalOnTrans => totalExpenseByCategory(ExpenseCategory.TRANSPORT);

  Future<String> getJson() {
    return rootBundle.loadString('assets/expense.json');
  }

  void addDataToList() async {
    final List parsed = json.decode(await getJson());

    List<Expense> list = parsed.map((e) => Expense.fromJson(e)).toList();

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

  List<Expense> sortedExpenses() {
    List<Expense> temp = _expenses;
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

  List<Expense> expensesOfMonth() {
    if (_expenses.isEmpty) addDataToList();
    List<Expense> weeklyExpense = [];

    _expenses.forEach((element) {
      if (element.date.month == DateTime.now().month) {
        weeklyExpense.add(element);
      }
    });

    return weeklyExpense;
  }

  List<Expense> expensesOfDay() {
    if (_expenses.isEmpty) addDataToList();
    List<Expense> weeklyExpense = [];

    _expenses.forEach((element) {
      if (element.date.day == DateTime.now().day) {
        weeklyExpense.add(element);
      }
    });

    return weeklyExpense;
  }

  void printExpenses({List<Expense> expense}) {
    if (_expenses.isEmpty) addDataToList();
    var list = expense ?? _expenses;
    list.forEach((element) => print(element));
  }
}

// List<Expense> _expense = [
//     Expense(
//       amount: 200,
//       category: ExpenseCategory.FOOD,
//       time: TimeOfDay(hour: 12, minute: 10),
//       date: DateTime.now(),
//       note: 'Ate shwarma',
//     ),
//     Expense(
//         amount: 300,
//         category: ExpenseCategory.TRANSPORT,
//         time: TimeOfDay(hour: 13, minute: 20),
//         date: DateTime.parse('2020-12-27'),
//         note: 'Sunday Trip'),
//     Expense(
//         amount: 100,
//         category: ExpenseCategory.OTHERS,
//         time: TimeOfDay(hour: 18, minute: 00),
//         date: DateTime.parse('2020-12-26'),
//         note: 'Can\'t remember'),
//     Expense(
//         amount: 170,
//         category: ExpenseCategory.EDUCATION,
//         time: TimeOfDay(hour: 10, minute: 00),
//         date: DateTime.parse('2020-12-20'),
//         note: 'Bought Notebook'),
//     Expense(
//         amount: 1000,
//         category: ExpenseCategory.SHOPPING,
//         time: TimeOfDay(hour: 12, minute: 00),
//         date: DateTime.parse('2020-12-25'),
//         note: 'Got Dresses'),
//     Expense(
//         amount: 300,
//         category: ExpenseCategory.ENTERTAINMENT,
//         time: TimeOfDay(hour: 16, minute: 00),
//         date: DateTime.parse('2020-12-25'),
//         note: 'Moviesssss'),
//     Expense(
//       amount: 400,
//       category: ExpenseCategory.FOOD,
//       time: TimeOfDay(hour: 12, minute: 10),
//       date: DateTime.parse('2020-12-01'),
//       note: 'Ate pizza',
//     ),
//   ];
