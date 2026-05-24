import 'dart:developer';

abstract class SecurityUtil {
  void rotateSecurityKeys();
}

final class SecurityUtilImpl implements SecurityUtil {
  @override
  void rotateSecurityKeys() {
    log("Rotating localized cryptographic DB security blocks...");
  }
}
