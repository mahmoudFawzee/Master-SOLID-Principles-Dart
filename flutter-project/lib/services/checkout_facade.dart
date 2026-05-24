import '/services/cart_service.dart';
import '/services/checkout_service.dart';
import '/services/local_storage.dart';
import '/services/payment_gateway.dart';

abstract interface class CheckoutFacade {
  void checkout(PaymentProvider paymentProvider);
}

final class CheckoutFacadeImpl implements CheckoutFacade {
  final CartService _cartService;
  final CheckoutService _checkoutService;
  final LocalStorage _localStorage;
  const CheckoutFacadeImpl(
    this._cartService,
    this._checkoutService,
    this._localStorage,
  );
  @override
  void checkout(PaymentProvider paymentProvider) {
    final totalAmount = _cartService.totalCartPrice;
    _checkoutService.executeCheckout(paymentProvider, totalAmount);
    _localStorage.writeToDisk(
      "ORDER_${DateTime.now().millisecondsSinceEpoch}",
      "Total: $totalAmount EGP",
    );
    _cartService.clear();
  }
}
