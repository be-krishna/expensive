import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../resources/constants.dart';

class ChooseCategory extends StatefulWidget {
  final IconData labelIcon;
  final String labelText;
  final Function onTapFunction;
  final TextEditingController controller;
  final Function onChangeFunction;
  ChooseCategory(
      {Key key,
      this.labelIcon,
      this.labelText,
      this.onTapFunction,
      this.controller,
      this.onChangeFunction})
      : super(key: key);

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  ExpenseCategory selectedCategory = ExpenseCategory.FOOD;

  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem<ExpenseCategory>> menuItems = [];

    for (ExpenseCategory cat in items) {
      menuItems.add(
        DropdownMenuItem(
          child: Text(cat.toString().split('.').last),
          value: cat,
        ),
      );
    }

    return menuItems;
  }

  final List<ExpenseCategory> items = [
    ExpenseCategory.EDUCATION,
    ExpenseCategory.ENTERTAINMENT,
    ExpenseCategory.FOOD,
    ExpenseCategory.SHOPPING,
    ExpenseCategory.TRANSPORT,
    ExpenseCategory.OTHERS,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              widget.labelIcon,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 20),
            Text(
              widget.labelText,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
        DropdownButtonFormField(
          value: selectedCategory,
          items: getDropdownItems(),
          onChanged: widget.onChangeFunction,
          decoration: kTextFieldDecoration,
          dropdownColor: Color(0xff0a0e21),
        ),
      ],
    );
  }
}
