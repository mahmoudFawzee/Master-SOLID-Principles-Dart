import 'dart:developer';

abstract interface class PaymentProvider {
  void pay(double amount);
}

final class VodafoneCashGateway implements PaymentProvider {
  final String number;
  const VodafoneCashGateway(this.number);
  @override
  void pay(double amount) {
    log("SUCCESS: Deducted $amount EGP from wallet connection path $number");
  }
}

final class InstapayGateway implements PaymentProvider {
  final String number;
  const InstapayGateway(this.number);
  @override
  void pay(double amount) {
    log("InstaPay gateway sync parameters missing, unavailable now");
  }
}
