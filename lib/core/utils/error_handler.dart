import 'package:flutter/material.dart';

class ErrorHandler {
  static handle(Function() function) {
    try {
      function;
    } catch (e) {
      print(e);
    }
  }

  static void handleWithDialog(BuildContext context, Function function) {
    try {
      function();
    } catch (e) {
      // Show an AlertDialog with the error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('$e'),
          actions: [
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }
}
