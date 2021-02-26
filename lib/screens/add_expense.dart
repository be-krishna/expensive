import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../models/expense_data.dart';
import '../widgets/add_expense_button.dart';
import '../widgets/category_select.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  bool _autoValidate = false;
  ExpenseCategory category;
  double amount;
  String note;
  String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.fromDateTime(DateTime.now());

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  void _selectDateCopy() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime.now(),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        selectedDate = newDate;
        _dateController.text = DateFormat.yMMMd().format(selectedDate);
      });
    }
  }

  void _selectTimeCopy() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (newTime != null) {
      setState(() {
        selectedTime = newTime;
        _timeController.text = selectedTime.format(context);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  InputDecoration _inputDecoration({Icon icon, String labelText}) {
    return InputDecoration(
      labelText: labelText ?? "Add Label",
      icon: icon ?? Icon(Icons.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Add New',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  itemExtent: 120,
                  children: [
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontFamily: 'OpenSans', fontSize: 16),
                      decoration: _inputDecoration(
                        icon: Icon(Icons.monetization_on_sharp),
                        labelText: "Amount",
                      ),
                      onChanged: (value) {
                        setState(() {
                          amount = double.parse(value);
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter amount";
                        }
                        if (double.parse(value).isNaN ||
                            double.parse(value).isNegative) {
                          return "Enter correct amount";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _noteController,
                      style: TextStyle(fontFamily: 'OpenSans', fontSize: 16),
                      decoration: _inputDecoration(
                        icon: Icon(Icons.note_add),
                        labelText: "Detail",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Detail";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          note = value.toString();
                        });
                      },
                    ),
                    ChooseCategory(
                      onChangeFunction: (value) {
                        setState(() {
                          category = value;
                        });
                      },
                      formValidator: (value) =>
                          value == null ? 'Select Category' : null,
                    ),
                    TextFormField(
                      controller: _dateController,
                      decoration: _inputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Date",
                      ),
                      style: TextStyle(fontFamily: 'OpenSans', fontSize: 16),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Date";
                        }
                        return null;
                      },
                      onTap: () => _selectDateCopy(),
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: _timeController,
                      decoration: _inputDecoration(
                        icon: Icon(Icons.alarm),
                        labelText: "Time",
                      ),
                      style: TextStyle(fontFamily: 'OpenSans', fontSize: 16),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Time";
                        }
                        return null;
                      },
                      onTap: () => _selectTimeCopy(),
                      readOnly: true,
                    ),
                  ],
                ),
              ),
            ),
            Builder(
              builder: (context) => AddExpenseButton(
                onTapFunction: () {
                  if (_formKey.currentState.validate()) {
                    Provider.of<ExpenseData>(context, listen: false).addExpense(
                      amount: amount,
                      date: selectedDate,
                      time: selectedTime,
                      category: category,
                      note: note,
                    );

                    _dateController.clear();
                    _timeController.clear();
                    _amountController.clear();
                    _noteController.clear();

                    _autoValidate = false;

                    FocusScope.of(context).unfocus();

                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Task added')),
                    );
                  } else {
                    _autoValidate = true;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
