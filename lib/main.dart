import 'package:expensive/screens/deleted_expenses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/deleted_expense_data.dart';
import 'models/expense_data.dart';
import 'screens/add_expense_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/expense_history_screen.dart';
import 'screens/recent_expenses_screen.dart';
import 'screens/update_expense_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExpenseData>(create: (_) => ExpenseData()),
        ChangeNotifierProvider<DeletedExpenseData>(
            create: (_) => DeletedExpenseData())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Dashboard(),
        routes: {
          Dashboard.routeName: (context) => Dashboard(),
          ExpenseHistory.routeName: (context) => ExpenseHistory(),
          RecentExpense.routeName: (context) => RecentExpense(),
          UpdateExpense.routeName: (context) => UpdateExpense(),
          AddExpense.routeName: (context) => AddExpense(),
          DeletedExpense.routeName: (context) => DeletedExpense(),
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
