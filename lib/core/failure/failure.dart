import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Failure extends Equatable {
  final String ?code;
  final String? message;
  final Widget ?failureWidget;

  const Failure({ this.code,  this.message ,this.failureWidget});

  @override
  List<Object?> get props => [
    code,
    message,
    failureWidget
  ];
}
