class UserValidator {
  /// Validates a password.
  /// Returns true if valid, false if invalid.
  bool validatePassword(String password) {
    if (password.length < 6) {
      print("Password too short.");
      return false;
    }
    return true;
  }
}

class SecureUserValidator extends UserValidator {
  @override
  bool validatePassword(String password) {
    // VIOLATION: Tightening preconditions!
    // The base class promised that any string >= 6 chars is acceptable to evaluate.
    // This subclass arbitrarily throws a crash exception if it doesn't meet a higher bar.
    if (password.length < 10 || !password.contains(RegExp(r'[!@#]'))) {
      throw FormatException(
        "Secure passwords must be 10+ characters and contain a special character!",
      );
    }
    return true;
  }
}
