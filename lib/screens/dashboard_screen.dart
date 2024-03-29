import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/expense_data.dart';
import '../widgets/widget_dashboard_chart.dart';
import '../widgets/widget_drawer_child.dart';
import '../widgets/widget_latest_expense.dart';
import '../widgets/widget_reusable_card.dart';
import 'add_expense_screen.dart';
import 'expense_history_screen.dart';
import 'recent_expenses_screen.dart';

const activeCardColor = Color(0xff090723);

class Dashboard extends StatefulWidget {
  static const String routeName = '/inputPage';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    ExpenseData().refreshList;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Expensive",
          style: TextStyle(fontFamily: "OpenSans"),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: activeCardColor),
        child: Drawer(
          child: DrawerChild(),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 3,
              child: ReusableCard(
                color: Colors.transparent,
                border: false,
                cardChild: Hero(tag: "chart", child: DashboardChart()),
              ),
            ),
            Expanded(
              child: LatestExpense(),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ReusableCard(
                      color: activeCardColor,
                      onTapFunction: () {
                        Navigator.of(context).pushNamed(RecentExpense.routeName);
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
                            style:
                                TextStyle(fontSize: 18, color: Colors.grey, fontFamily: 'OpenSans'),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      color: activeCardColor,
                      onTapFunction: () {
                        Navigator.of(context).pushNamed(ExpenseHistory.routeName);
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
                            style:
                                TextStyle(fontSize: 18, color: Colors.grey, fontFamily: 'OpenSans'),
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
                            text: NumberFormat('#,##,###.00', 'en_US').format(value.total),
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
          Navigator.of(context).pushNamed(AddExpense.routeName);
        },
      ),
    );
  }
}
