import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

class ListItem extends StatelessWidget {
  final String note;
  final DateTime date;
  final TimeOfDay time;
  final ExpenseCategory category;
  final double amount;
  final Function onTapCallback;

  ListItem({
    Key key,
    this.note,
    this.date,
    this.time,
    this.category,
    this.amount,
    this.onTapCallback,
  }) : super(key: key);

  Icon getIcon(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.FOOD:
        return Icon(
          Icons.fastfood_outlined,
          color: Colors.blue,
          size: 30,
        );
      case ExpenseCategory.EDUCATION:
        return Icon(
          Icons.school_outlined,
          color: Colors.pink,
          size: 30,
        );
      case ExpenseCategory.TRANSPORT:
        return Icon(
          Icons.commute_outlined,
          color: Colors.yellow,
          size: 30,
        );
      case ExpenseCategory.ENTERTAINMENT:
        return Icon(
          Icons.theaters_outlined,
          color: Colors.teal,
          size: 30,
        );
      case ExpenseCategory.SHOPPING:
        return Icon(
          Icons.shopping_bag_outlined,
          color: Colors.red,
          size: 30,
        );
      default:
        return Icon(
          Icons.money_outlined,
          color: Colors.green,
          size: 30,
        );
    }
  }

  final formatter = NumberFormat.currency(locale: "en_IN", symbol: "₹");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              getIcon(category).color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          margin: EdgeInsets.all(1),
          shape: RoundedRectangleBorder(),
          color: Color(0xff090723),
          child: ListTile(
            leading: getIcon(category),
            title: Text(
              note,
              style: TextStyle(fontSize: 18, fontFamily: 'OpenSans'),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: date != null ? Text('${DateFormat.yMMMMd().format(date)}') : null,
            trailing: Text('${formatter.format(amount)}'),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            onTap: onTapCallback,
          ),
        ),
      ),
    );
  }
}
