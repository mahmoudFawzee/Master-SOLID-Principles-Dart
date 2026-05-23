abstract interface class SmartShopUser {
  void processSale();
  void scanBarcode();
  void updateProductStock();
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

  // CRITICAL / VIOLATION: Cashiers should never delete stock or view total profits!
  @override
  void deleteProduct() {
    throw UnimplementedError(
      "Cashiers cannot delete products from the system!",
    );
  }

  @override
  void viewProfitReports() {
    throw UnimplementedError(
      "Access Denied: Cashiers cannot view profit reports!",
    );
  }
}
