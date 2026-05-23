// Low-Level Detail (The underlying implementation detail)
class VodafoneCashService {
  void initiateWalletTransfer(String phone, double amount) {
    print("Transferred $amount EGP via Vodafone Cash to $phone");
  }
}

// High-Level Module (The business core policy rule)
class OrderCheckoutService {
  late VodafoneCashService _paymentService;

  OrderCheckoutService() {
    // CRITICAL VIOLATION: Hardcoded coupling to a concrete low-level class!
    _paymentService = VodafoneCashService();
  }

  void checkoutOrder(String userPhone, double orderTotal) {
    print("Processing order checkout...");
    _paymentService.initiateWalletTransfer(userPhone, orderTotal);
  }
}
