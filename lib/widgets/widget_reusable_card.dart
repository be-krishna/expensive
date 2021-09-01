import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.color, this.cardChild, this.onTapFunction, this.border});
  final Color color;
  final Widget cardChild;
  final Function onTapFunction;
  final bool border;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          // border: border == false ? null : Border.all(color: Colors.pink),
          gradient: LinearGradient(
            colors: [
              Colors.pink,
              Colors.pink.shade100,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Card(
          margin: EdgeInsets.all(1),
          child: cardChild,
          color: Color(0xff090723),
        ),
      ),
    );
  }
}
