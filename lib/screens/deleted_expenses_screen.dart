import 'package:expensive/models/expense_data.dart';
import 'package:expensive/widgets/widget_no_expense_prompt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../widgets/widget_list_item.dart';

class DeletedExpense extends StatefulWidget {
  static const String routeName = '/deletedExpense';
  @override
  _DeletedExpenseState createState() => _DeletedExpenseState();
}

class _DeletedExpenseState extends State<DeletedExpense> {
  List<Expense> _expenses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Deleted',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        centerTitle: true,
      ),
      body: Consumer<ExpenseData>(
        builder: (context, _data, _) => _data.deletedExpenses.isEmpty
            ? NoExpensePrompt()
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemCount:
                          _expenses == null ? _data.deletedExpenses.length : _expenses.length,
                      itemBuilder: (context, index) {
                        var temp = _data.deletedExpenses;
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
                              //method call to remove data forever
                              _data.deleteExpense(entry, restore: true);
                            } else {
                              // method call to restore data
                              _data.addExpense(entry);
                              _data.deleteExpense(entry, restore: true);
                            }
                          },
                          background: sliderBackground(
                            context: context,
                            icon: Icons.restore,
                            iconLabel: "Restore",
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
