abstract interface class HardwareEngine {
  void configureBackgroundSyncInterval(int minutes);
}

final class HardwareEngineImpl implements HardwareEngine {
  // 4. Violates ISP: Forcing a standard transaction processor engine to carry
  // background battery optimizations and crypto-key rotation configurations it shouldn't touch.
  @override
  void configureBackgroundSyncInterval(int minutes) {
    print("Setting hardware wake-lock alarm interval to $minutes minutes.");
  }
}
