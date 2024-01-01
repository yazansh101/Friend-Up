import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/managers/cash_manager/cash_keys.dart';
import 'package:movie_app/core/managers/manager.dart';

import '../../../features/auth/domain/entities/user_entity.dart';
import 'app_manager_state.dart';

class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(const AppManagerState());

  Locale locale = const Locale('en');

  UserEntity? user;

  Future<void> init() async {
    await loadLocalizations();
    await loadUserData();
    Logger().i('AppManagerCubit init');
  }

  Future<void> loadLocalizations() async {
    Managers.cashManager.get<String>(CashKeys.locale).then((value) {
      if (value != null) {
        locale = Locale(value.toString());
        emit(
          state.copyWith(
            locale: locale,
          ),
        );
      }
    });
  }

  void changeLocale(String newLocale) {
    Managers.cashManager.store(CashKeys.locale, newLocale);
    locale = Locale(newLocale);
    emit(
      state.copyWith(
        locale: locale,
      ),
    );
  }

  Future<void> loadUserData() async {
    final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
   
   
  }
}
