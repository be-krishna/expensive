import 'package:flutter/material.dart';

import '../resources/constants.dart';

class AddTransactionField extends StatelessWidget {
  final IconData labelIcon;
  final String labelText;
  final Function onTapFunction;
  final TextEditingController controller;
  final Function onChangeFunction;
  final Function formValidator;
  const AddTransactionField({
    Key key,
    this.labelIcon,
    this.labelText,
    this.onTapFunction,
    this.controller,
    this.onChangeFunction,
    this.formValidator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              labelIcon,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 20),
            Text(
              labelText,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
        TextFormField(
          decoration: kTextFieldDecoration,
          style: TextStyle(color: Colors.white, fontSize: 18),
          cursorColor: Colors.white,
          onTap: onTapFunction,
          controller: controller,
          onChanged: onChangeFunction,
          validator: formValidator,
        ),
      ],
    );
  }
}
