abstract interface class SecureStorage {
  String get name;

  Future<String> read(String key);
  Future<void> write(String key, value);
  Future<void> delete(String key);
}
