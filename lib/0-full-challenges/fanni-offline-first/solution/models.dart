enum TransactionMangerEnum { mock, natural, wallet }

class LocalTransaction {
  final String id;
  final double amountEgp;
  final String localTimestamp;
  LocalTransaction(this.id, this.amountEgp, this.localTimestamp);
  Map<String, dynamic> toJson() {
    return {"tx_id": id, "amount": amountEgp};
  }

  TransactionMangerEnum get whichType {
    if (id.startsWith("MOCK_")) return TransactionMangerEnum.mock;

    if (id.startsWith("WALLET_DEPOSIT")) return TransactionMangerEnum.wallet;

    return TransactionMangerEnum.natural;
  }
}
