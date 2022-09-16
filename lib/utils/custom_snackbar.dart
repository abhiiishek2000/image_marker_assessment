import 'package:flutter/material.dart';


void showSnackBar(
    { required BuildContext context,
      required String message,
      required bool isError}) {
  final snackBar = SnackBar(
    content: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    ),
    duration: const Duration(seconds: 1),
    backgroundColor: isError ? Colors.red : Colors.green,
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}