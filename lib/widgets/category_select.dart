import 'package:flutter/material.dart';

import '../models/expense.dart';

class ChooseCategory extends StatefulWidget {
  final Function onTapFunction;
  final TextEditingController controller;
  final Function onChangeFunction;
  final Function formValidator;
  ChooseCategory(
      {Key key,
      this.onTapFunction,
      this.controller,
      this.onChangeFunction,
      this.formValidator})
      : super(key: key);

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  ExpenseCategory selectedCategory;

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
    return DropdownButtonFormField<ExpenseCategory>(
      value: selectedCategory,
      items: getDropdownItems(),
      onChanged: widget.onChangeFunction,
      dropdownColor: Color(0xff090723),
      validator: widget.formValidator,
      decoration: InputDecoration(
        labelText: "Category",
        icon: Icon(Icons.category),
      ),
    );
  }
}
