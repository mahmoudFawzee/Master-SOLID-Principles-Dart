abstract interface class LocalRepository {
  // Auth Operations
  void saveAuthToken(String token);
  String? getAuthToken();
  void clearAuthSession();

  // Shopping Cart Operations
  void cacheCartItems(List<Map<String, dynamic>> items);
  List<Map<String, dynamic>> getCartItems();

  // App UI Preferences
  void saveThemeMode(String mode);
  String getThemeMode();

  // System Diagnostics
  void logDeviceMetric(String metric);
  List<String> getDeviceMetrics();
}

// A specific service that ONLY handles keeping the user logged in
class AuthenticationManager {
  final LocalRepository _storage;

  AuthenticationManager(this._storage);

  void login(String freshToken) {
    _storage.saveAuthToken(freshToken);
  }

  void logout() {
    _storage.clearAuthSession();
  }
}
