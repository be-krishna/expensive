import 'package:expensive/screens/add_expense.dart';
import 'package:expensive/screens/expense_history.dart';
import 'package:expensive/screens/recent_expenses.dart';
import 'package:expensive/screens/update_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/expense_data.dart';
import 'screens/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Dashboard(),
        routes: {
          Dashboard.routeName: (context) => Dashboard(),
          ExpenseHistory.routeName: (context) => ExpenseHistory(),
          RecentExpense.routeName: (context) => RecentExpense(),
          UpdateExpense.routeName: (context) => UpdateExpense(),
          AddExpense.routeName: (context) => AddExpense(),
        },
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xff090723),
          accentColor: Colors.pink,
          scaffoldBackgroundColor: Color(0xff090723),
          snackBarTheme: SnackBarThemeData(
              backgroundColor: Color(0xff090723),
              contentTextStyle: TextStyle(color: Colors.pink)),
        ),
      ),
    );
  }
}
