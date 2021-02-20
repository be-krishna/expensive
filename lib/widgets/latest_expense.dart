import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../models/expense_data.dart';
import 'list_item.dart';

class LatestExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        try {
          return ListItem(
            amount: value.latestExpense.amount ?? 0,
            category: value.latestExpense.category ?? ExpenseCategory.OTHERS,
            date: value.latestExpense.date ?? DateTime.now(),
            note: value.latestExpense.note ?? "Loading ...",
            time: value.latestExpense.time ??
                TimeOfDay.fromDateTime(DateTime.now()),
            onTapCallback: () {},
          );
        } catch (e) {
          return LinearProgressIndicator(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          );
        }
      },
    );
  }
}
