import 'package:expensive/screens/expense_history.dart';
import 'package:expensive/screens/recent_expenses.dart';
import 'package:expensive/widgets/latest_epense.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/add_expense_button.dart';
import '../widgets/dashboard_chart.dart';
import '../widgets/reusable_card.dart';
import 'add_expense.dart';

const activeCardColor = Color(0xff1d1e33);

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/profile.png'),
                foregroundImage: AssetImage('assets/images/profile.png'),
              ),
            ),
            Expanded(
              flex: 3,
              child: ReusableCard(
                color: Colors.transparent,
                cardChild: DashboardChart(),
              ),
            ),
            // Expanded(child: ReusableCard(color: activeCardColor)),
            Expanded(
              child: LatestExpense(),
            ),
            // TransactionItem(),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ReusableCard(
                      color: activeCardColor,
                      onTapFunction: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecentExpense()));
                      },
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.history,
                            size: 50,
                          ),
                          SizedBox(height: 15),
                          Text(
                            "History",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      color: activeCardColor,
                      onTapFunction: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExpenseHistory()));
                      },
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.chartPie,
                            size: 50,
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Statistics",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: AddExpenseButton(
                onTapFunction: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddExpense()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
