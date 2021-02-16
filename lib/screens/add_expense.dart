import 'package:expensive/widgets/add_expense_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../models/expense_data.dart';
import '../resources/constants.dart';
import '../widgets/add_transaction_field.dart';
import '../widgets/category_select.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  ExpenseCategory category;
  double amount;
  String note;
  String _hour, _minute, _time;
  String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark().copyWith(
                primary: kSkyCrayola,
                surface: kBgBlue,
              ),
            ),
            child: child,
          );
        });
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark().copyWith(
                primary: kSkyCrayola,
                surface: kBgBlue,
              ),
            ),
            child: child,
          );
        });
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = DateFormat('h:mm a')
            .format(DateTime(selectedDate.year, selectedDate.month,
                selectedDate.day, selectedTime.hour, selectedTime.minute))
            .toString();
      });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AddTransactionField(
                          labelIcon: Icons.calendar_today,
                          labelText: 'Date',
                          controller: _dateController,
                          onTapFunction: () {
                            _selectDate(context);
                          },
                          formValidator: (value) {
                            if (value.empty) {
                              return "Please select date.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 40),
                        AddTransactionField(
                          labelIcon: Icons.alarm,
                          labelText: 'Time',
                          controller: _timeController,
                          onTapFunction: () async {
                            _selectTime(context);
                          },
                          formValidator: (value) {
                            if (value.isEmpty) {
                              return "Please select time.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 40),
                        AddTransactionField(
                          labelIcon: Icons.attach_money,
                          labelText: 'Amount',
                          controller: _amountController,
                          onChangeFunction: (value) {
                            amount = double.parse(value);
                          },
                          formValidator: (value) {
                            if (value.isEmpty) {
                              return "Please enter amount.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 40),
                        ChooseCategory(
                          labelIcon: Icons.category,
                          labelText: 'Category',
                          onChangeFunction: (value) {
                            setState(() {
                              category = value;
                            });
                          },
                        ),
                        SizedBox(height: 40),
                        AddTransactionField(
                          labelIcon: Icons.text_snippet,
                          labelText: 'Note',
                          controller: _noteController,
                          onChangeFunction: (value) {
                            note = value;
                          },
                          formValidator: (value) {
                            if (value.isEmpty) {
                              return "Please enter detail.";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AddExpenseButton(
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

                  FocusScope.of(context).unfocus();
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Task added'),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
