import 'package:flutter/material.dart';

class ErrorHandler {
  static void showErrorDialog(BuildContext context, {required String message}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  static Future<T?> handleApiError<T>(
    Future<T?> Function() apiCall,
    BuildContext context, {
    required String errorMessage,
  }) async {
    try {
      final response = await apiCall();
      return response;
    } on NetworkException {
      showErrorDialog(context, message: 'Network error. Please check your internet connection and try again.');
    } on AuthorizationException {
      showErrorDialog(context, message: 'Authorization error. Please login and try again.');
    } catch (e) {
      showErrorDialog(context, message: errorMessage);
    }
  }
}

class NetworkException implements Exception {}

class AuthorizationException implements Exception {}
