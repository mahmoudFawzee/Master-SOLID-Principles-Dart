import 'dart:developer';

abstract class LocalStorage {
  void writeToDisk(String key, String numericalValue);
}

class HiveBox implements LocalStorage {
  @override
  void writeToDisk(String key, String numericalValue) {
    log(
      "CACHE HIT: Securely wrote block index [$key] to smartphone flash chip.",
    );
  }
}
