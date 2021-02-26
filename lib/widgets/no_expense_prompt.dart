import 'package:flutter/material.dart';

class NoExpensePrompt extends StatelessWidget {
  const NoExpensePrompt({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "It's lonely here! Please spend some money!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 32),
      ),
    );
  }
}
