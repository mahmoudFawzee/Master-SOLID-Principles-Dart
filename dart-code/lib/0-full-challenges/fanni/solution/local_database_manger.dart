abstract interface class LocalDatabase {
  void saveToFile(String path);
}

final class LocalDatabaseImpl implements LocalDatabase {
  @override
  void saveToFile(String path) => print("Saving PDF file to $path");
}
