import '/models/shop_item.dart';

abstract class ProductsService {
  List<ShopItem> get products;
}

final class ProductsServiceImpl implements ProductsService {
  @override
  List<ShopItem> get products => [
    ShopItem(
      id: "PT_01",
      name: "Bosch Professional Drill",
      priceEgp: 4500.0,
      category: "PowerTool",
    ),
    ShopItem(
      id: "HT_02",
      name: "Stanley Socket Wrench Set",
      priceEgp: 1800.0,
      category: "HandTool",
    ),
    ShopItem(
      id: "ST_03",
      name: "3M Heavy Duty Safety Glasses",
      priceEgp: 450.0,
      category: "Safety",
    ),
  ];
}
