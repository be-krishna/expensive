import 'package:flutter/material.dart';

import '../models/expense.dart';

class ChooseCategory extends StatefulWidget {
  final Function onTapFunction;
  final TextEditingController controller;
  final Function onChangeFunction;
  final Function onSavedFunction;
  final Function formValidator;
  final ExpenseCategory selectedCategory;
  ChooseCategory(
      {Key key,
      this.onTapFunction,
      this.controller,
      this.onChangeFunction,
      this.onSavedFunction,
      this.formValidator,
      this.selectedCategory})
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
      value: widget.selectedCategory != null
          ? widget.selectedCategory
          : selectedCategory,
      items: getDropdownItems(),
      onChanged: widget.onChangeFunction,
      onSaved: widget.onSavedFunction,
      dropdownColor: Color(0xff090723),
      validator: widget.formValidator,
      decoration: InputDecoration(
        labelText: "Category",
        icon: Icon(Icons.category),
      ),
    );
  }
}
