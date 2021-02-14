import 'package:flutter/material.dart';

const bottomContainerHeight = 50.0;
class AddExpenseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        height: bottomContainerHeight,
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
