import '/0-full-challenges/fanni-offline-first/solution/models.dart';

abstract class QueueManger {
  List<LocalTransaction> get queue;
  void queueTransaction(LocalTransaction tx);
}

final class QueueMangerImpl implements QueueManger {
  static final QueueMangerImpl _instance = QueueMangerImpl._internal();
  QueueMangerImpl._internal();
  factory QueueMangerImpl() => _instance;
  final List<LocalTransaction> _queue = [];
  @override
  List<LocalTransaction> get queue => _queue;

  @override
  void queueTransaction(LocalTransaction tx) {
    if (tx.amountEgp <= 0) {
      print("خطأ: لا يمكن جدولة معاملة فارغة");
      return;
    }
    _queue.add(tx);
    print("SUCCESS: Transaction ${tx.id} queued at ${tx.localTimestamp}");
  }
}
