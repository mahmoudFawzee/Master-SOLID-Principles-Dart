import '/services/payment_gateway.dart';

abstract class CheckoutService {
  void executeCheckout(PaymentProvider walletProvider, double totalAmount);
}

final class CheckoutServiceImpl implements CheckoutService {
  @override
  void executeCheckout(PaymentProvider walletProvider, double totalAmount) =>
      walletProvider.pay(totalAmount);
}
