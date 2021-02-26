import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget FilledButton(String text, Color splashColor, Color highlightColor,
    Color fillColor, Color textColor, void function()) {
  return RaisedButton(
    highlightElevation: 0.0,
    splashColor: splashColor,
    highlightColor: highlightColor,
    elevation: 5.0,
    color: fillColor,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(30.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: textColor, fontSize: 20.0),
      ),
    ),
    onPressed: () {
      function();
    },
  );
}
