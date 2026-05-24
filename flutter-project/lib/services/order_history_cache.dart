abstract class OrderHistoryCache {
  List<String> get localOrderHistoryCache;
  void add(String value);
  int get length;
  bool get isEmpty;
}

final class OrderHistoryCacheImpl implements OrderHistoryCache {
  final List<String> _localOrderHistoryCache = [];

  @override
  List<String> get localOrderHistoryCache => _localOrderHistoryCache;

  @override
  void add(String value) => _localOrderHistoryCache.add(value);

  @override
  int get length => _localOrderHistoryCache.length;

  @override
  bool get isEmpty => _localOrderHistoryCache.isEmpty;
}
