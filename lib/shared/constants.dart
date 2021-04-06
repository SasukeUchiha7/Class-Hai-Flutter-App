import 'package:flutter/material.dart';

// input field decoration
const inputTextDecoration = InputDecoration(
  hintStyle: TextStyle(
    fontSize: 14.0,
    letterSpacing: 0.7,
    color: Colors.grey,
  ),
);

//sign and reg field font family
const inputTextLabel = TextStyle(
  fontFamily: 'OpenSans',
);

//Card tile input containers
Container cardInputContainer(dynamic v) {
  return Container(
    child: v,
    padding: EdgeInsets.all(11),
    margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
    decoration: BoxDecoration(
      color: Colors.grey[50],
      borderRadius: BorderRadius.circular(7),
    ),
  );
}


var buttonColor = Colors.cyan[900];
