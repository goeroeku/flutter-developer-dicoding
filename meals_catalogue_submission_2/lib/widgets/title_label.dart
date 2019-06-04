import 'package:flutter/material.dart';

class TitleLabel extends StatelessWidget {
  final String label;

  TitleLabel({this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
          child: Text(
            "$label",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
