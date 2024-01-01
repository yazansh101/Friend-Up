
import 'package:movie_app/core/managers/cash_manager/cash_manager.dart';
import 'package:movie_app/core/service_locator/service_locator.dart';

class Managers {
  static CashManager cashManager = getIt<CashManager>();
}
