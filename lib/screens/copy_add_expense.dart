import 'package:expensive/models/expense.dart';
import 'package:expensive/widgets/add_expense_button.dart';
import 'package:expensive/widgets/copy_category_select.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CopyAddExpense extends StatefulWidget {
  @override
  _CopyAddExpenseState createState() => _CopyAddExpenseState();
}

class _CopyAddExpenseState extends State<CopyAddExpense> {
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
                primary: Colors.pink,
                surface: Colors.indigo,
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
                primary: Colors.pink,
                surface: Colors.indigo,
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  itemExtent: 120,
                  children: [
                    TextFormField(
                      controller: _amountController,
                      decoration: _inputDecoration(
                        icon: Icon(Icons.monetization_on_sharp),
                        labelText: "Amount",
                      ),
                      style: TextStyle(fontSize: 16),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter amount";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _noteController,
                      decoration: _inputDecoration(
                        icon: Icon(Icons.note_add),
                        labelText: "Detail",
                      ),
                      style: TextStyle(fontSize: 16),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Detail";
                        }
                        return null;
                      },
                    ),
                    CopyChooseCategory(
                      onChangeFunction: (value) {
                        setState(() {
                          category = value;
                        });
                      },
                    ),
                    TextFormField(
                      controller: _dateController,
                      decoration: _inputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Date",
                      ),
                      style: TextStyle(fontSize: 16),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Date";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _timeController,
                      decoration: _inputDecoration(
                        icon: Icon(Icons.alarm),
                        labelText: "Time",
                      ),
                      style: TextStyle(fontSize: 16),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Time";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            AddExpenseButton(
              onTapFunction: () {
                if (_formKey.currentState.validate()) {
                  print("validated");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
