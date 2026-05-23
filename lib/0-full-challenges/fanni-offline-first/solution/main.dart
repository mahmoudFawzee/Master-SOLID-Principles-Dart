// Concrete Wallet Transaction
import 'package:solid_principles_with_dart/0-full-challenges/fanni-offline-first/solution/transaction_manger.dart';

import '/0-full-challenges/fanni-offline-first/solution/models.dart';
import '/0-full-challenges/fanni-offline-first/solution/network_client.dart';
import '/0-full-challenges/fanni-offline-first/solution/queue_manger.dart';
import '/0-full-challenges/fanni-offline-first/solution/sync_queue.dart';

void main() {
  final networkClient = NativeNetworkClient();
  final queueManger = QueueMangerImpl();
  final processor = SyncQueueMangerProcessor(
    MockTransactionsManger(),
    WalletTransactionsManger(),
    NaturalTransactionsManger(networkClient),
  );
  final syncEngine = SyncMangerImpl(processor, queueManger);

  // Queue up different transaction types
  queueManger.queueTransaction(
    LocalTransaction("TX_001", 450.0, "2026-05-23 10:00"),
  );
  queueManger.queueTransaction(
    LocalTransaction("MOCK_999", 0.01, "2026-05-23 10:01"),
  );

  // Works fine for standard transactions
  syncEngine.processSyncQueue();

  print("\n--- CRASH TESTING TRANSITION --- \n");

  // CRASH ZONE: This will completely destroy the queue execution loop mid-way!
  queueManger.queueTransaction(
    LocalTransaction("WALLET_DEPOSIT_88", 1200.0, "2026-05-23 10:02"),
  );
  syncEngine.processSyncQueue(); // Boom! UnsupportedError uncaught crash.
}
