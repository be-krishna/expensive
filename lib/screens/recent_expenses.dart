import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense_data.dart';
import '../widgets/list_item.dart';

class RecentExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0a0e21),
      body: SafeArea(
        child: Column(
          children: [
            // TODO: Add Sort Functionality
            Expanded(
              child: Consumer<ExpenseData>(
                builder: (context, data, widget) => ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: data.expenses.length,
                    itemBuilder: (context, index) {
                      var temp = data.sortedExpenses();
                      var entry = temp[index];
                      return ListItem(
                        amount: entry.amount,
                        note: entry.note,
                        date: entry.date,
                        category: entry.category,
                        time: entry.time,
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
