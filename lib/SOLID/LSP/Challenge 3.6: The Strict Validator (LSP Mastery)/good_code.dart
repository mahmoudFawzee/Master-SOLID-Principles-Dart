abstract class Validator {
  bool validatePassword(String password);
}

class UserValidator implements Validator {
  /// Validates a password.
  /// Returns true if valid, false if invalid.
  @override
  bool validatePassword(String password) {
    if (password.length < 6) {
      print("Password too short.");
      return false;
    }
    return true;
  }
}

class SecureUserValidator implements Validator {
  @override
  bool validatePassword(String password) {
    // VIOLATION: Tightening preconditions!
    // The base class promised that any string >= 6 chars is acceptable to evaluate.
    // This subclass arbitrarily throws a crash exception if it doesn't meet a higher bar.
    if (password.length < 10 || !password.contains(RegExp(r'[!@#]'))) {
      print(
        "Secure passwords must be 10+ characters and contain a special character!",
      );
      return false;
    }
    return true;
  }
}

void registerUsers(List<String> passwords, Validator validator) {
  for (final password in passwords) {
    // The service checked that "secret123" is 9 characters long.
    // According to the base UserValidator contract, this should cleanly return true or false.
    if (validator.validatePassword(password)) {
      print("User registered successfully.");
    } else {
      print("Registration failed: Invalid password.");
    }
  }
}
