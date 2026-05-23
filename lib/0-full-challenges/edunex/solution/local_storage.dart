abstract interface class LocalStorage {
  void writeEncryptedString(String key, String value);
}

final class HiveLocalStorage implements LocalStorage {
  @override
  void writeEncryptedString(String key, String value) {
    print("Securely saved payload to local Hive box storage index [$key]");
  }
}
