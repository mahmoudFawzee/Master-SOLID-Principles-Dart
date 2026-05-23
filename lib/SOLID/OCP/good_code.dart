class Order {
  final double totalAmount;
  Order({required this.totalAmount});
}

abstract interface class PaymentModel {
  void pay(Order order);
}

final class CreditCard implements PaymentModel {
  @override
  void pay(Order order) {
    print("Processing \$${order.totalAmount} via Credit Card...");
  }
}

final class PayPal implements PaymentModel {
  @override
  void pay(Order order) {
    print("Processing \$${order.totalAmount} via PayPal...");
  }
}

class PaymentProcessor {
  final PaymentModel _paymentModel;
  const PaymentProcessor(this._paymentModel);
  void processPayment(Order order) => _paymentModel.pay(order);
}
