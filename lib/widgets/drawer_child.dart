import 'package:flutter/material.dart';

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
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  title: Text(
                    'Import',
                    style: TextStyle(fontFamily: "OpenSans", fontSize: 16),
                  ),
                  trailing: Icon(Icons.file_download),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  title: Text(
                    'Export',
                    style: TextStyle(fontFamily: "OpenSans", fontSize: 16),
                  ),
                  trailing: Icon(Icons.file_upload),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
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
