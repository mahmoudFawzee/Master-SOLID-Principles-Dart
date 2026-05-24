enum PaymentType { creditCard, payPal }

class Order {
  final double totalAmount;
  Order({required this.totalAmount});
}

class PaymentProcessor {
  void processPayment(Order order, PaymentType type) {
    if (type == PaymentType.creditCard) {
      print("Processing \$${order.totalAmount} via Credit Card...");
      // Credit card charging logic here
    } else if (type == PaymentType.payPal) {
      print("Processing \$${order.totalAmount} via PayPal...");
      // PayPal routing logic here
    }
    // Every time we add a payment method, we must modify this class!
  }
}
