
import 'package:flutter/material.dart';

class Players extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
        children: <Widget>[
          Icon(FontAwesomeIcons.users),
        ],
      ),
    );
  }

  void add(String name) {

  }
}