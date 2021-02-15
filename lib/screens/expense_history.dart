import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../models/expense_data.dart';
import '../widgets/list_item.dart';
import '../widgets/stats_chart.dart';

class ExpenseHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ExpenseData>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StatsChart.withSampleData(),
          )),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                ListItem(
                  amount: data.totalExpenseByCategory(ExpenseCategory.FOOD),
                  category: ExpenseCategory.FOOD,
                  note: 'Food and Drinks',
                  date: DateTime.now(),
                ),
                ListItem(
                  amount:
                      data.totalExpenseByCategory(ExpenseCategory.TRANSPORT),
                  category: ExpenseCategory.TRANSPORT,
                  note: 'Transport',
                  date: DateTime.now(),
                ),
                ListItem(
                  amount:
                      data.totalExpenseByCategory(ExpenseCategory.EDUCATION),
                  category: ExpenseCategory.EDUCATION,
                  note: 'Education',
                  date: DateTime.now(),
                ),
                ListItem(
                  amount: data.totalExpenseByCategory(ExpenseCategory.SHOPPING),
                  category: ExpenseCategory.SHOPPING,
                  note: 'Shopping',
                  date: DateTime.now(),
                ),
                ListItem(
                  amount: data
                      .totalExpenseByCategory(ExpenseCategory.ENTERTAINMENT),
                  category: ExpenseCategory.ENTERTAINMENT,
                  note: 'Entertainment',
                  date: DateTime.now(),
                ),
                ListItem(
                  amount: data.totalExpenseByCategory(ExpenseCategory.OTHERS),
                  category: ExpenseCategory.OTHERS,
                  note: 'Others',
                  date: DateTime.now(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
