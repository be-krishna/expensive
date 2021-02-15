import 'package:expensive/models/expense_data.dart';
import 'package:expensive/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LatestExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => ListItem(
        amount: value.latestExpense.amount,
        category: value.latestExpense.category,
        date: value.latestExpense.date,
        note: value.latestExpense.note,
        time: value.latestExpense.time,
        onTapCallback: () {},
      ),
    );
  }
}
