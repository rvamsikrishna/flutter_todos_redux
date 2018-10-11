import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key key,
  }) : super(key: key);

  Widget buildIcon(IconData icon) {
    return Icon(
      icon,
      color: Colors.grey,
      size: 35.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
      child: Row(
        children: <Widget>[
          buildIcon(Icons.menu),
          Expanded(
            child: Text(
              'TODO',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          buildIcon(Icons.search),
        ],
      ),
    );
  }
}
