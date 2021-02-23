import 'package:expensive/models/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// <div>Icons made by <a href="https://www.flaticon.com/authors/eucalyp" title="Eucalyp">Eucalyp</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>

class DrawerChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "assets/images/icon.png",
                          scale: 6,
                        ),
                        Text(
                          "expensive",
                          style: TextStyle(fontFamily: "Satisfy", fontSize: 32),
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer<ExpenseData>(
                  builder: (context, value, _) => ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    title: Text(
                      'Import',
                      style: TextStyle(fontFamily: "OpenSans", fontSize: 16),
                    ),
                    trailing: Icon(Icons.file_download),
                    onTap: () async {
                      bool imported = await value.importFromJson();
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              imported ? Text("Imported") : Text("Error")));
                    },
                  ),
                ),
                Consumer<ExpenseData>(
                  builder: (context, value, _) => ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    title: Text(
                      'Export',
                      style: TextStyle(fontFamily: "OpenSans", fontSize: 16),
                    ),
                    trailing: Icon(Icons.file_upload),
                    onTap: () async {
                      var message = await value.exportToJson();
                      message = message.split("/").last;
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("$message saved to Downloads folder")));
                    },
                  ),
                ),
                Consumer<ExpenseData>(
                  builder: (context, value, _) => ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    title: Text(
                      'Clear DB',
                      style: TextStyle(fontFamily: "OpenSans", fontSize: 16),
                    ),
                    trailing: Icon(Icons.delete),
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text("Are you sure?"),
                          title: Text("Clear Database"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                value.clearTable();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Database Cleared")),
                                );
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontFamily: "OpenSans",
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                "No",
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontFamily: "OpenSans",
                                ),
                              ),
                            ),
                          ],
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Made with love",
            style: TextStyle(fontFamily: "Satisfy", fontSize: 16),
          ),
        ],
      ),
    );
  }
}
