import 'package:expensive/models/expense_data.dart';
import 'package:flutter/foundation.dart';

import '../services/database_helper.dart';
import 'expense.dart';

class DeletedExpenseData extends ChangeNotifier {
  DatabaseHelper _dbHelper;
  DeletedExpenseData() {
    _dbHelper = DatabaseHelper.instance;
    _addDataToList();
    notifyListeners();
  }

  List<Expense> get deletedExpense => sortedExpenses();

  List<Expense> _deletedExpense = [];

  List<Expense> sortedExpenses() {
    List<Expense> temp = _deletedExpense;
    temp.sort((a, b) => a.compareTo(b));
    return temp;
  }

  void _addDataToList() async {
    List<Expense> list =
        await _dbHelper.fetchExpenses(tableName: DatabaseHelper.deletedExpenseTable);

    _deletedExpense = list;
    notifyListeners();
  }

  refreshExpenseList() async {
    _deletedExpense = await _dbHelper.fetchExpenses(tableName: DatabaseHelper.deletedExpenseTable);
    notifyListeners();
  }

  void restoreExpense(Expense expense) async {
    ExpenseData _expenseData = ExpenseData();
    _expenseData.addExpense(expense);
    removeExpense(expense);
    refreshExpenseList();
    notifyListeners();
  }

  void addExpense(Expense expense) {
    _dbHelper.insertExpense(expense, tableName: DatabaseHelper.deletedExpenseTable);
    refreshExpenseList();
    notifyListeners();
  }

  void removeExpense(Expense expense) async {
    await _dbHelper.deleteExpense(expense, tableName: DatabaseHelper.deletedExpenseTable);
    refreshExpenseList();
    notifyListeners();
  }
}
