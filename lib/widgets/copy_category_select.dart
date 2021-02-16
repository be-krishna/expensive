import 'package:flutter/material.dart';

import '../models/expense.dart';

class CopyChooseCategory extends StatefulWidget {
  final Function onTapFunction;
  final TextEditingController controller;
  final Function onChangeFunction;
  final Function formValidator;
  CopyChooseCategory(
      {Key key,
      this.onTapFunction,
      this.controller,
      this.onChangeFunction,
      this.formValidator})
      : super(key: key);

  @override
  _CopyChooseCategoryState createState() => _CopyChooseCategoryState();
}

class _CopyChooseCategoryState extends State<CopyChooseCategory> {
  ExpenseCategory selectedCategory = ExpenseCategory.FOOD;

  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem<ExpenseCategory>> menuItems = [];

    for (ExpenseCategory category in items) {
      menuItems.add(
        DropdownMenuItem(
          child: Text(category.toString().split('.').last),
          value: category,
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
    return DropdownButtonFormField(
      value: selectedCategory,
      items: getDropdownItems(),
      onChanged: widget.onChangeFunction,
      dropdownColor: Color(0xff0a0e21),
      validator: widget.formValidator,
      decoration: InputDecoration(
        labelText: "Category",
        icon: Icon(Icons.category),
      ),
    );
  }
}
