import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Color(0xff090723),
        child: ListTile(
            leading: Container(
              child: Icon(
                Icons.theaters,
              ),
              height: double.infinity,
            ), //getIcon(category),
            title: Text(
              "Movies",
              style: TextStyle(fontSize: 18),
            ),
            subtitle:
                Text("13 Feb"), //Text('${DateFormat.yMMMMd().format(date)}'),
            trailing: Text(
              "+ 10,000.00",
              style: TextStyle(fontSize: 18),
            ), //Text('${formatter.format(amount)}'),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            onTap: () {} //(onTapCallback),
            ),
      ),
    );
  }
}
