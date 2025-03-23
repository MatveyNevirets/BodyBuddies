abstract interface class SecureStorage {
  String get name;

  Future<void> read(String key);
  Future<void> write(String key, value);
  Future<void> delete(String key);
}
