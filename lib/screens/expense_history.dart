import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../models/expense_data.dart';
import '../widgets/list_item.dart';
import '../widgets/stats_chart.dart';

class ExpenseHistory extends StatefulWidget {
  @override
  _ExpenseHistoryState createState() => _ExpenseHistoryState();
}

class _ExpenseHistoryState extends State<ExpenseHistory> {
  List<Expense> _expenses;
  @override
  Widget build(BuildContext context) {
    ExpenseData _data = Provider.of<ExpenseData>(context);
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.pink,
        icon: Icon(Icons.sort),
        label: Text("Sort"),
        onPressed: () async {
          List<Expense> _list = await showModalBottomSheet(
            backgroundColor: Color(0xff0a0e21),
            context: context,
            builder: (context) {
              return Wrap(
                children: [
                  ListTile(
                    title: Text('All'),
                    onTap: () {
                      Navigator.of(context).pop(_data.expenses);
                    },
                  ),
                  ListTile(
                    title: Text('This Year'),
                    onTap: () {
                      Navigator.of(context).pop(_data.expensesOfYear());
                    },
                  ),
                  ListTile(
                    title: Text('This Month'),
                    onTap: () {
                      Navigator.of(context).pop(_data.expensesOfMonth());
                    },
                  ),
                  ListTile(
                    title: Text('This Week'),
                    onTap: () {
                      Navigator.of(context).pop(_data.expensesOfWeek());
                    },
                  ),
                  ListTile(
                    title: Text('Today'),
                    onTap: () {
                      Navigator.of(context).pop(_data.expensesOfDay());
                    },
                  ),
                ],
              );
            },
          );
          setState(() {
            _expenses = _list;
          });
        },
      ),
    );
  }
}
