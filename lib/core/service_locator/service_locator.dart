import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/core/common/app_manager/app_manager_cubit.dart';
import 'package:movie_app/core/managers/cash_manager/cash_manager.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  ///Utils
  getIt.registerSingleton<CashManager>(CashManagerImpl());
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  getIt.registerSingleton<AppManagerCubit>(AppManagerCubit());
}
