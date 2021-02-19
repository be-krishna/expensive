import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/expense_data.dart';
import 'screens/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: InputPage(),
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xff0a0e21),
          accentColor: Colors.pink,
          scaffoldBackgroundColor: Color(0xff090723),
        ),
      ),
    );
  }
}
