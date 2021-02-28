import 'package:flutter/material.dart';

Future<void> showDialog({BuildContext context, IconData iconData, String helperText}) {
  return showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.8),
    transitionDuration: Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, __, ___) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          height: 200,
          child: Column(
            children: [
              Icon(
                iconData,
                size: 100,
              ),
              SizedBox(height: 10),
              Expanded(
                child: Text(
                  helperText ?? "Text",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}
