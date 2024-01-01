import 'dart:ui';

import 'package:equatable/equatable.dart';

class AppManagerState extends Equatable {
  final Locale? locale;

  const AppManagerState({
    this.locale,
  });

  AppManagerState copyWith({Locale? locale,}) {
    return AppManagerState(
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [locale,];
}
