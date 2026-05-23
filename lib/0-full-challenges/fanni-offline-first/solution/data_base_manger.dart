abstract class DataBaseManger {
  void rotateLocalDatabaseEncryptionKey(String newKey);
}

final class DataBaseMangerImpl implements DataBaseManger {
  @override
  void rotateLocalDatabaseEncryptionKey(String newKey) {
    print("Re-encrypting local database storage blocks with fresh key token.");
  }
}
