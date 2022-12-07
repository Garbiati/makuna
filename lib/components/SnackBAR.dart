import 'package:flutter/material.dart';

void showSnackBAR(
    String text, BuildContext context, Color bgColor, Color textColor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: TextStyle(color: textColor, fontSize: 15),
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: bgColor,
  ));
}
