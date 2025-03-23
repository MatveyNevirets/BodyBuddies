import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';

class FlutterSecureStorage implements SecureStorage {
  final storage = FlutterSecureStorage();

  @override
  Future<void> delete(String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  Future<void> read(String key) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<void> write(String key, value) {
    // TODO: implement write
    throw UnimplementedError();
  }
}
