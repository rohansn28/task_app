import 'package:flutter/material.dart';

void showSnackBar(context, msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 600),
      backgroundColor: Colors.black,
    ),
  );
}
