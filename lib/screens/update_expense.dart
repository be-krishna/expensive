import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../models/expense_data.dart';
import '../services/database_helper.dart';
import '../widgets/add_expense_button.dart';
import '../widgets/category_select.dart';
import 'recent_expenses.dart';

class UpdateExpense extends StatefulWidget {
  final int id;
  final double amount;
  final String note;
  final DateTime date;
  final TimeOfDay time;
  final ExpenseCategory category;

  UpdateExpense({
    Key key,
    this.id,
    this.amount,
    this.note,
    this.date,
    this.time,
    this.category,
  }) : super(key: key);
  @override
  _UpdateExpenseState createState() => _UpdateExpenseState();
}

class _UpdateExpenseState extends State<UpdateExpense> {
  bool _autoValidate = false;
  ExpenseCategory category;
  double amount;
  String note = "note";
  String dateTime;
  DateTime selectedDate;
  TimeOfDay selectedTime;

  TextEditingController _dateController;
  TextEditingController _timeController;
  TextEditingController _categoryController;
  TextEditingController _amountController;
  TextEditingController _noteController;

  void getExpense() async {
    var db = DatabaseHelper.instance;
    Expense expense = await db.getExpenseById(widget.id);
    print(expense);
  }

  @override
  void initState() {
    _amountController = TextEditingController(text: widget.amount.toString());
    _noteController = TextEditingController(text: widget.note);
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    _categoryController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _selectDateCopy() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: widget.date,
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
      initialTime: widget.time,
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
                      onSaved: (value) {
                        setState(() {
                          amount = double.parse(value) ?? widget.amount;
                        });
                      },
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
                      onSaved: (value) {
                        setState(() {
                          note = value.toString() ?? widget.note;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          note = value.toString();
                        });
                      },
                    ),
                    ChooseCategory(
                      controller: _categoryController,
                      selectedCategory: widget.category,
                      onChangeFunction: (ExpenseCategory value) {
                        setState(() {
                          category = value;
                        });
                      },
                      onSavedFunction: (ExpenseCategory value) {
                        setState(() {
                          category = category ?? widget.category;
                        });
                      },
                      formValidator: (ExpenseCategory value) {
                        if (value.index.isNaN) {
                          return 'Select Category';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: _dateController
                        ..text = DateFormat.yMMMd().format(widget.date),
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
                      onSaved: (value) {
                        setState(() {
                          selectedDate = selectedDate ?? widget.date;
                        });
                      },
                      onTap: () => _selectDateCopy(),
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: _timeController
                        ..text = widget.time.format(context),
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
                      onSaved: (value) {
                        setState(() {
                          selectedTime = selectedTime ?? widget.time;
                        });
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
                    _formKey.currentState.save();
                    Provider.of<ExpenseData>(context, listen: false)
                        .updatExpense(
                      Expense(
                        id: widget.id,
                        amount: amount,
                        date: selectedDate,
                        time: selectedTime,
                        category: category,
                        note: note,
                      ),
                    );

                    _autoValidate = false;

                    FocusScope.of(context).unfocus();
                    showDialog(context);
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

  void showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.8),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 200,
            child: Column(
              children: [
                Icon(
                  Icons.update,
                  size: 100,
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Text(
                    "Updated",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    ).then((value) => Navigator.of(context)
        .pop(MaterialPageRoute(builder: (context) => RecentExpense())));
  }
}
