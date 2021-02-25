import 'package:flutter/material.dart';

enum ExpenseCategory {
  FOOD,
  EDUCATION,
  SHOPPING,
  TRANSPORT,
  ENTERTAINMENT,
  OTHERS,
}

class Expense implements Comparable<Expense> {
  static const tblExpense = 'expenses';
  static const colId = 'id';
  static const colAmt = 'amount';
  static const colDate = 'date';
  static const colCat = 'category';
  static const colNote = 'note';
  static const colTime = 'time';

  int id;
  double amount;
  DateTime date;
  ExpenseCategory category;
  String note;
  TimeOfDay time;

  Expense({
    @required this.amount,
    @required this.date,
    @required this.category,
    @required this.time,
    this.note,
    this.id,
  });

  Expense.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    date = DateTime.parse(json['date'].toString());
    category = getCategory(json['category']);
    note = json['note'];
    time = TimeOfDay(
      hour: int.parse(json['time'].split(':').first),
      minute: int.parse(json['time'].split(':').last),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date.toIso8601String(),
      'time': _timeToString(time),
      'amount': amount,
      'category': category.index,
      'note': note,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  Map toJson() {
    return {
      'date': date.toIso8601String(),
      'time': _timeToString(time),
      'amount': amount,
      'category': category.index,
      'note': note,
    };
  }

  Expense.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    date = DateTime.parse(map['date']);
    time = _stringToTime(map['time']);
    amount = map['amount'];
    category = getCategory(map['category']);
    note = map['note'].toString();
  }

  String _timeToString(TimeOfDay timeOfDay) {
    return '${timeOfDay.hour}:${timeOfDay.minute}';
  }

  TimeOfDay _stringToTime(String s) {
    return TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
  }

  ExpenseCategory getCategory(int index) {
    switch (index) {
      case 0:
        return ExpenseCategory.FOOD;
      case 1:
        return ExpenseCategory.EDUCATION;
      case 2:
        return ExpenseCategory.SHOPPING;
      case 3:
        return ExpenseCategory.TRANSPORT;
      case 4:
        return ExpenseCategory.ENTERTAINMENT;
      default:
        return ExpenseCategory.OTHERS;
    }
  }

  @override
  String toString() {
    return "$amount spent on ${category.toString().split('.').last} on $date.";
  }

  @override
  int compareTo(Expense object) {
    if (this.date.day == object.date.day &&
        this.date.month == object.date.month) {
      if (this.time.hour == object.time.hour) {
        if (this.time.minute < object.time.minute) {
          return -1;
        } else {
          return 1;
        }
      } else if (this.time.hour > object.time.hour) {
        return -1;
      } else {
        return 1;
      }
    }
    if (this.date.isAfter(object.date)) {
      return -1;
    } else if (this.date.isBefore(object.date)) {
      return 1;
    } else {
      return 0;
    }
  }
}
