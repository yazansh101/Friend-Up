import 'package:movie_app/core/common/app_manager/app_manager_cubit.dart';
import 'package:movie_app/core/localization/localization.dart';
import 'package:movie_app/core/service_locator/service_locator.dart';

extension LocalExtension on String {
  String get tr {
    final locale = getIt<AppManagerCubit>().locale;
    return translateMap[this]?[locale.languageCode] ?? '';
  }
}
