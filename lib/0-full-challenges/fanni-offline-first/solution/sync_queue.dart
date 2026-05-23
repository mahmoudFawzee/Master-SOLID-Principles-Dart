import 'package:solid_principles_with_dart/0-full-challenges/fanni-offline-first/solution/transaction_manger.dart';
import '/0-full-challenges/fanni-offline-first/solution/queue_manger.dart';

abstract class SyncManger {
  void processSyncQueue();
}

final class SyncMangerImpl implements SyncManger {
  final QueueManger _queueManger;
  final SyncQueueMangerProcessor _queueMangerProcessor;
  const SyncMangerImpl(this._queueMangerProcessor, this._queueManger);

  @override
  // 2. Violates OCP & LSP: Hardcoded sync rules for different transaction behaviors.
  // It completely alters or crashes depending on the sync route, breaking the contract.
  void processSyncQueue() {
    print("Beginning batch sync operation...");
    final queue = _queueManger.queue;
    for (final tx in queue) {
      _queueMangerProcessor.processSyncQueue(tx);
    }

    queue.clear();
  }
}
