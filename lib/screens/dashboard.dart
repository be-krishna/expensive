import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/expense_data.dart';
import '../widgets/dashboard_chart.dart';
import '../widgets/latest_expense.dart';
import '../widgets/reusable_card.dart';
import 'add_expense.dart';
import 'expense_history.dart';
import 'recent_expenses.dart';

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
                cardChild: Hero(tag:"chart", child: DashboardChart()),
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
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 16, fontFamily: "OpenSans"),
                  ),
                  Consumer<ExpenseData>(
                    builder: (context, value, child) => RichText(
                      text: TextSpan(
                        text: '₹ ',
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: NumberFormat('#,##,###.00', 'en_US')
                                .format(value.total),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans",
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("New"),
        backgroundColor: Colors.pink,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddExpense()));
        },
      ),
    );
  }
}
