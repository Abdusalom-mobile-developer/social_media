import 'package:flutter/material.dart';

Widget customText(String content, Color color, double fontSize,
    FontWeight fontWeight, String fontFamily) {
  return Text(
    content,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
    ),
  );
}