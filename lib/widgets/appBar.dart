import 'package:flutter/material.dart';

PreferredSizeWidget mainAppBar(BuildContext context) {
  return AppBar(
    title: Center(
      child: Text(
        'Howdy?',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    ),
    backgroundColor: Colors.amberAccent,
  );
}
