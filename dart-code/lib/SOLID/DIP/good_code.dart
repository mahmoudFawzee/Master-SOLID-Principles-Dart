abstract interface class WalletService {
  void initiateWalletTransfer(String phone, double amount);
}

class VodafoneCashService implements WalletService {
  @override
  void initiateWalletTransfer(String phone, double amount) {
    print("Transferred $amount EGP via Vodafone Cash to $phone");
  }
}

class OrderCheckoutService {
  final WalletService _paymentService;

  OrderCheckoutService(this._paymentService);

  void checkoutOrder(String userPhone, double orderTotal) {
    print("Processing order checkout...");
    _paymentService.initiateWalletTransfer(userPhone, orderTotal);
  }
}
