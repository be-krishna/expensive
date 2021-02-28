import 'package:flutter/material.dart';

const bottomContainerHeight = 50.0;

class SubmitButton extends StatelessWidget {
  final Function onTapFunction;
  final IconData buttonIcon;

  const SubmitButton({Key key, this.onTapFunction, this.buttonIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        height: bottomContainerHeight,
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              buttonIcon ?? Icons.add,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
