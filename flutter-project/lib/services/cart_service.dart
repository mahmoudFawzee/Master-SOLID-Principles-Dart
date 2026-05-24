import '/models/shop_item.dart';

abstract class CartService {
  List<ShopItem> get cartItems;
  void clear();
  double get totalCartPrice;
  void addItem(ShopItem item);
  int get itemsLength;
  bool get isEmpty;
}

final class CartServiceImpl implements CartService {
  final List<ShopItem> _cartItems = [];
  @override
  List<ShopItem> get cartItems => _cartItems;

  @override
  void clear() => _cartItems.clear();

  @override
  double get totalCartPrice =>
      _cartItems.fold(0, (sum, item) => sum + item.priceEgp);

  @override
  void addItem(ShopItem item) => _cartItems.add(item);

  @override
  int get itemsLength => _cartItems.length;

  @override
  bool get isEmpty => _cartItems.isEmpty;
}
