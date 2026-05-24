// Concrete Wallet Transaction
class LocalTransaction {
  final String id;
  final double amountEgp;
  final String localTimestamp;
  LocalTransaction(this.id, this.amountEgp, this.localTimestamp);
}

// THE TIME BOMB MONOLITH: Violates S, O, L, I, and D simultaneously!
class FanniSyncEngine {
  final List<LocalTransaction> _queue = [];

  // 1. Violates SRP: Mixes data collection, queue manipulation, and log format formatting
  void queueTransaction(LocalTransaction tx) {
    if (tx.amountEgp <= 0) {
      print("خطأ: لا يمكن جدولة معاملة فارغة");
      return;
    }
    _queue.add(tx);
    print("SUCCESS: Transaction ${tx.id} queued at ${tx.localTimestamp}");
  }

  // 2. Violates OCP & LSP: Hardcoded sync rules for different transaction behaviors.
  // It completely alters or crashes depending on the sync route, breaking the contract.
  void processSyncQueue() {
    print("Beginning batch sync operation...");

    for (final tx in _queue) {
      // Direct low-level dependency instantiation (Violates DIP)
      final network = NativeNetworkClient();

      // Violates OCP & LSP: Custom treatment based on arbitrary hardcoded ID string rules
      if (tx.id.startsWith("MOCK_")) {
        // Violates LSP: Changing state behavior invisibly during what should be a read-only sync sync pipeline!
        print(
          "Skipping real network upload for test transaction. Silently mutating log state.",
        );
        continue;
      }

      if (tx.id.startsWith("WALLET_DEPOSIT")) {
        // Violates LSP: Abruptly throwing a crash exception halfway through processing a queue
        // if an integration rule isn't perfectly met.
        throw UnsupportedError(
          "CRITICAL: Wallet sync requires a secure secondary handshake pin!",
        );
      }

      // 3. Violates DIP: Directly hardcoding an end-point payload format and execution line
      final payload = '{"tx_id": "${tx.id}", "amount": ${tx.amountEgp}}';
      network.sendPayload("https://api.fanni-app.eg/v1/sync", payload);
    }

    _queue.clear();
  }

  // 4. Violates ISP: Forcing a standard transaction processor engine to carry
  // background battery optimizations and crypto-key rotation configurations it shouldn't touch.
  void configureBackgroundSyncInterval(int minutes) {
    print("Setting hardware wake-lock alarm interval to $minutes minutes.");
  }

  void rotateLocalDatabaseEncryptionKey(String newKey) {
    print("Re-encrypting local database storage blocks with fresh key token.");
  }
}

// Low-Level Detail
class NativeNetworkClient {
  void sendPayload(String endpoint, String body) {
    print(
      "Sending encrypted bytes to $endpoint -> Content-Length: ${body.length}",
    );
  }
}

void main() {
  final syncEngine = FanniSyncEngine();

  // Queue up different transaction types
  syncEngine.queueTransaction(
    LocalTransaction("TX_001", 450.0, "2026-05-23 10:00"),
  );
  syncEngine.queueTransaction(
    LocalTransaction("MOCK_999", 0.01, "2026-05-23 10:01"),
  );

  // Works fine for standard transactions
  syncEngine.processSyncQueue();

  print("\n--- CRASH TESTING TRANSITION --- \n");

  // CRASH ZONE: This will completely destroy the queue execution loop mid-way!
  syncEngine.queueTransaction(
    LocalTransaction("WALLET_DEPOSIT_88", 1200.0, "2026-05-23 10:02"),
  );
  syncEngine.processSyncQueue(); // Boom! UnsupportedError uncaught crash.
}
