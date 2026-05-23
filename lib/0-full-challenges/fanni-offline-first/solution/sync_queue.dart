import '/0-full-challenges/fanni-offline-first/solution/network_client.dart';
import '/0-full-challenges/fanni-offline-first/solution/queue_manger.dart';

abstract class SyncManger {
  void processSyncQueue();
}

final class SyncMangerImpl implements SyncManger {
  final NetworkClient network;
  final QueueManger _queueManger;
  const SyncMangerImpl(this.network, this._queueManger);

  @override
  // 2. Violates OCP & LSP: Hardcoded sync rules for different transaction behaviors.
  // It completely alters or crashes depending on the sync route, breaking the contract.
  void processSyncQueue() {
    print("Beginning batch sync operation...");

    for (final tx in _queueManger.queue) {
      // Direct low-level dependency instantiation (Violates DIP)

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

    _queueManger.queue.clear();
  }
}
