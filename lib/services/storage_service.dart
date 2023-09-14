// ignore_for_file: public_member_api_docs

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  factory StorageService() => StorageService._();

  StorageService._() : _sharedPreferences = SharedPreferences.getInstance();

  final Future<SharedPreferences> _sharedPreferences;

  Future<void> write({
    required String key,
    required String value,
  }) async {
    final sp = await _sharedPreferences;
    await sp.setString(
      key,
      value,
    );
    return;
  }

  Future<String?> read(
    String key,
  ) async {
    final sp = await _sharedPreferences;
    final value = sp.getString(
      key,
    );
    return value;
  }

  Future<void> delete(
    String key,
  ) async {
    final sp = await _sharedPreferences;
    await sp.remove(
      key,
    );
    return;
  }
}
