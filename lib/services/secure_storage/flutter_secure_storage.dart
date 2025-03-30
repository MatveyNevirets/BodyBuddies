import 'dart:developer';

import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageImpl implements SecureStorage {
  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions.defaultOptions,
      iOptions: IOSOptions.defaultOptions);

  @override
  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  @override
  String get name => "FlutterSecureStorage";

  @override
  Future<String> read(String key) async {
    final String? token = await storage.read(key: key);
    return token ?? "";
  }

  @override
  Future<void> write(String key, value) async {
    await storage.write(key: key, value: value);
  }
}
