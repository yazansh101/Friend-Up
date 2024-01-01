import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Cash manager is responsible for managing storing and retrieving data
// from local storage.

abstract class CashManager {
  // Converting the data to string using json encoding
  // then store it as string in local storage.
  // NOTE: The custom classes or the type that it's not
  // general is not supported by this method.
  Future<void> store(String key, dynamic value);

  // Get the data as string from local storage.
  // Then convert the string to dynamic value using json decoder.
  // If the value is null then the return type will be null
  // if the value matches the type [T] then the return type will be [T].
  // NOTE: The custom classes or the type that it's not supported.
  Future<T?> get<T>(String key);

  ///Remove the data from local storage.
  Future<void> remove(String key);
}

class CashManagerImpl implements CashManager {
  @override
  Future<T?> get<T>(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    Logger().w('CashManager get $key  with type $T................');
    final data = sharedPreferences.getString(key);
    final decodedData = jsonDecode(data ?? '[]');
    if (decodedData is T) {
      Logger().w(
          'CashManager the data with key $key is found with data $decodedData');
      return decodedData;
    } else {
      Logger().w('CashManager the data with key $key is not found.');
      return null;
    }
  }

  @override
  Future<void> store(String key, value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final encodedData = jsonEncode(value);
    Logger().w('CashManager store $value with key $key in shared preferences.');
    await sharedPreferences.setString(key, encodedData);
  }

  @override
  Future<void> remove(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    Logger()
        .w('CashManager remove value with key $key from shared preferences.');
    sharedPreferences.remove(key);
  }
}
