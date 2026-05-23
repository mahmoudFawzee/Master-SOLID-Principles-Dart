import 'dart:convert';

import 'package:solid_principles_with_dart/0-full-challenges/fanni-offline-first/solution/models.dart';
import 'package:solid_principles_with_dart/0-full-challenges/fanni-offline-first/solution/network_client.dart';

final class SyncQueueMangerProcessor {
  final TransactionManger _mock, _wallet, _natural;
  const SyncQueueMangerProcessor(this._mock, this._wallet, this._natural);
  void processSyncQueue(LocalTransaction tx) {
    final txManger = _useTransactionManger(tx);
    txManger.processSyncQueue(tx);
  }

  TransactionManger _useTransactionManger(LocalTransaction tx) {
    if (tx.whichType == TransactionMangerEnum.mock) return _mock;

    if (tx.whichType == TransactionMangerEnum.wallet) return _wallet;

    return _natural;
  }
}

abstract interface class TransactionManger {
  void processSyncQueue(LocalTransaction tx);
}

final class MockTransactionsManger implements TransactionManger {
  @override
  void processSyncQueue(LocalTransaction tx) {
    print("Working on Mock transaction");
    print(
      "Skipping real network upload for test transaction. Silently mutating log state.",
    );
    return;
  }
}

final class WalletTransactionsManger implements TransactionManger {
  @override
  void processSyncQueue(LocalTransaction tx) {
    print("Working on Wallet transaction");

    return;
  }
}

final class NaturalTransactionsManger implements TransactionManger {
  final NetworkClient _network;
  const NaturalTransactionsManger(this._network);

  @override
  void processSyncQueue(LocalTransaction tx) {
    print("Working on Natural transaction");
    _network.sendPayload(
      "https://api.fanni-app.eg/v1/sync",
      json.encode(tx.toJson()),
    );
  }
}
