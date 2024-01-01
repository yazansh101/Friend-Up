
import 'exception_type.dart';

class AppException implements Exception  {
  final String ?message;
  final ExceptionType type;

  AppException({this.message, required this.type});

  @override
  String toString() {
    return 'AppException{code: $type, message: $message}';
  }
}

