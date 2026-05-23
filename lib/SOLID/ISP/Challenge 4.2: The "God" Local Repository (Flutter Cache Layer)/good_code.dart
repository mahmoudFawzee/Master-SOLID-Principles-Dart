abstract interface class AuthOperations {
  // Auth Operations
  void saveAuthToken(String token);
  String? getAuthToken();
  void clearAuthSession();
}

abstract interface class ShoppingCart {
  // Shopping Cart Operations
  void cacheCartItems(List<Map<String, dynamic>> items);
  List<Map<String, dynamic>> getCartItems();
}

abstract interface class UIPreferences {
  // System Diagnostics
  void logDeviceMetric(String metric);
  List<String> getDeviceMetrics();
}

abstract interface class SystemDiagnostics {
  // App UI Preferences
  void saveThemeMode(String mode);
  String getThemeMode();
}

// A specific service that ONLY handles keeping the user logged in
class AuthenticationManager {
  final AuthOperations _storage;

  AuthenticationManager(this._storage);

  void login(String freshToken) {
    _storage.saveAuthToken(freshToken);
  }

  void logout() {
    _storage.clearAuthSession();
  }
}
