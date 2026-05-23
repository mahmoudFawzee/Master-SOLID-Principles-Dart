abstract interface class SmartShopUser {
  void processSale();
  void scanBarcode();
  void updateProductStock();
}

abstract interface class SmartShopAdmin {
  void deleteProduct();
  void viewProfitReports();
}

// A frontline Cashier is forced to implement things they shouldn't touch!
class Cashier implements SmartShopUser {
  @override
  void processSale() => print("Sale processed successfully.");

  @override
  void scanBarcode() => print("Item scanned.");

  @override
  void updateProductStock() => print("Stock adjusted manually.");
}

class Admin implements SmartShopAdmin, SmartShopUser {
  @override
  void deleteProduct() => print("Sale deleted successfully.");

  @override
  void viewProfitReports() => print("view profit.");

  @override
  void processSale() => print("Sale processed successfully.");

  @override
  void scanBarcode() => print("Item scanned.");

  @override
  void updateProductStock() => print("Stock adjusted manually.");
}
