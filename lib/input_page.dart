import 'package:expensive/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/reusableCard.dart';

const activeCardColor = Color(0xff1d1e33);
const fabColor = Color(0xffeb1555);
const bottomContainerHeight = 50.0;

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
                radius: 28,
                backgroundImage: AssetImage('assets/images/profile.png'),
                foregroundImage: AssetImage('assets/images/profile.png'),
              ),
            ),
            Expanded(child: ReusableCard(color: Colors.white)),
            // Expanded(child: ReusableCard(color: activeCardColor)),
            TransactionItem(),
            TransactionItem(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ReusableCard(
                      color: activeCardColor,
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
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10),
                height: bottomContainerHeight,
                decoration: BoxDecoration(
                  color: fabColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 28,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
