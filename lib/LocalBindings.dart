import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

class LocalStorageBindings {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final storage = const FlutterSecureStorage();
  Future<void> write({required String key, dynamic value}) async {
    return await storage.write(key: key, value: value);
  }

  void deleteValue(String key) async {
    storage.delete(key: key, aOptions: _getAndroidOptions());
  }

  Future<String?> readValue(String key) async {
    String? value =
        await storage.read(key: key, aOptions: _getAndroidOptions());
    return value;
  }

  void deleteAll() async {
    storage.deleteAll(aOptions: _getAndroidOptions());
  }

  Future readAll() async {
    Map<String, String> value = await storage.readAll();
    return value;
  }
}

class LocalStorage {
  //singleton instance
  static LocalStorage sharedInstance = LocalStorage._internal();

  factory LocalStorage() {
    return sharedInstance;
  }

  Future<String?> loadUserRef(String key) async {
    return await localStorageBindings.readValue(key);
  }

  Future<dynamic> setUserRef({required String key, dynamic value}) async {
    localStorageBindings.write(key: key, value: value);
  }

  Future<String?> loadAuthStatus(String key) async {
    return await localStorageBindings.readValue(key);
  }

  Future<void> setAuthStatus({required String key, dynamic value}) async {
    localStorageBindings.write(key: key, value: value);
  }

  LocalStorageBindings localStorageBindings = LocalStorageBindings();

  LocalStorage._internal();

  void writeValue({required String key, dynamic value}) {
    localStorageBindings.write(key: key, value: value);
  }

  void deleteValue(String key) async {
    localStorageBindings.deleteValue(key);
  }

  Future<dynamic> readValue(String key) async {
    return await localStorageBindings.readValue(key);
  }

  void deleteAll() async {
    localStorageBindings.deleteAll();
  }

  Future readAll() async {
    return await localStorageBindings.readAll();
  }
}
