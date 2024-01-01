
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/exception/app_exception.dart';
import 'package:movie_app/core/extensions/localization_extension.dart';

import '../exception/exception_type.dart';
import '../failure/failure.dart';

extension ExceptionExtension on Exception {
  Failure get toFailure {
    if (this is AppException) {
      Logger().e({
        "message": (this as AppException).type.message,
        "title": (this as AppException).type.title,
      });
      return Failure(
        message: (this as AppException).type.message,
        code: (this as AppException).type.title,
        failureWidget: (this as AppException).type.errorWidget,
      );
    } else if (this is FirebaseException) {
      Logger().e(this);
      return Failure(
        message: (this as FirebaseException).message ?? "some_error_happened",
      );
    } else {
      Logger().e(this);
      return Failure(
          message: toString().replaceFirst("Exception: ", ""),
          code: 'Error',
          failureWidget: Container());
    }
  }
}

extension ExceptionTypeExtension on ExceptionType {
  String get message {
    switch (this) {
      case ExceptionType.noInternetConnection:
        return 'No Internet connection';
      case ExceptionType.loginException:
        return "please check email or password";
      case ExceptionType.global:
        return 'some_error_happened_please_try_again_later'.tr;
      case ExceptionType.missingData:
        return 'some_data_is_missing_please_try_again_later'.tr;
    }
  }

  String get title {
    switch (this) {
      case ExceptionType.noInternetConnection:
        return "No Internet";
      case ExceptionType.loginException:
        return "invalid email or password";
      case ExceptionType.global:
      case ExceptionType.missingData:
        return 'error'.tr;
    }
  }

  Widget get errorWidget {
    switch (this) {
      case ExceptionType.noInternetConnection:
      case ExceptionType.global:
      case ExceptionType.missingData:
        return Container();
      case ExceptionType.loginException:
        return Container();
    }
  }
}
