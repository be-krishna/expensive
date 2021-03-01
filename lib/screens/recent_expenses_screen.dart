import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../models/expense_data.dart';
import '../widgets/widget_list_item.dart';
import '../widgets/widget_no_expense_prompt.dart';
import 'update_expense_screen.dart';

class RecentExpense extends StatefulWidget {
  static const String routeName = '/recentExpense';
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
      body: _data.expenses.isEmpty
          ? NoExpensePrompt()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: _expenses == null ? _data.expenses.length : _expenses.length,
                    itemBuilder: (context, index) {
                      var temp = _data.sortedExpenses(customList: _expenses ?? _data.expenses);
                      var entry = temp[index];
                      return Dismissible(
                        key: UniqueKey(),
                        child: ListItem(
                          amount: entry.amount,
                          note: entry.note,
                          date: entry.date,
                          category: entry.category,
                          time: entry.time,
                        ),
                        onDismissed: (DismissDirection direction) {
                          if (direction == DismissDirection.endToStart) {
                            _data.deleteExpense(entry);
                          } else {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UpdateExpense(
                                  id: entry.id,
                                  amount: entry.amount,
                                  note: entry.note,
                                  date: entry.date,
                                  time: entry.time,
                                  category: entry.category,
                                ),
                              ),
                            );
                          }
                        },
                        background: sliderBackground(
                          context: context,
                          icon: Icons.edit,
                          iconLabel: "Edit",
                        ),
                        secondaryBackground: sliderBackground(
                          context: context,
                          icon: Icons.delete,
                          iconLabel: "Delete",
                          slideRight: false,
                        ),
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm"),
                                content: direction == DismissDirection.endToStart
                                    ? const Text("Are you sure you wish to delete this item?")
                                    : const Text("Update item?"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.pink),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: Colors.pink,
                                      ),
                                    ),
                                  ),
                                ],
                                backgroundColor: Theme.of(context).primaryColor,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: _data.expenses.isEmpty
          ? null
          : FloatingActionButton.extended(
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

Widget sliderBackground(
    {BuildContext context, IconData icon, String iconLabel, bool slideRight = true}) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Align(
      child: Row(
        mainAxisAlignment: slideRight ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            icon,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            iconLabel,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans"),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: slideRight ? Alignment.centerLeft : Alignment.centerRight,
    ),
  );
}
