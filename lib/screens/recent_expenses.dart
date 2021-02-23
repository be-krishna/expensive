import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../models/expense_data.dart';
import '../widgets/list_item.dart';

class RecentExpense extends StatefulWidget {
  @override
  _RecentExpenseState createState() => _RecentExpenseState();
}

class _RecentExpenseState extends State<RecentExpense> {
  List<Expense> _expenses;

  @override
  Widget build(BuildContext context) {
    ExpenseData _data = Provider.of<ExpenseData>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Recent',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount:
                  _expenses == null ? _data.expenses.length : _expenses.length,
              itemBuilder: (context, index) {
                var temp = _data.sortedExpenses(
                    customList: _expenses ?? _data.expenses);
                var entry = temp[index];
                return Dismissible(
                  key: Key(entry.id.toString()),
                  child: ListItem(
                    amount: entry.amount,
                    note: entry.note,
                    date: entry.date,
                    category: entry.category,
                    time: entry.time,
                  ),
                  onDismissed: (DismissDirection direction) =>
                      _data.removeDataFromList(entry.id),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.pink,
        icon: Icon(Icons.filter_list),
        label: Text("Filter"),
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
