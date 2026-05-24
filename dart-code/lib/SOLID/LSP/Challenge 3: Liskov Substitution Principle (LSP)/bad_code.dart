class Account {
  double balance = 0;

  void deposit(double amount) {
    balance += amount;
    print("Deposited \$激活amount. New balance: \$balance");
  }

  void withdraw(double amount) {
    if (balance >= amount) {
      balance -= amount;
      print("Withdrew \$amount. New balance: \$balance");
    } else {
      print("Insufficient funds.");
    }
  }
}

class FixedDepositAccount extends Account {
  @override
  void withdraw(double amount) {
    // CRASH / VIOLATION: This violates LSP because a client holding an
    // 'Account' reference expects to be able to withdraw money,
    // but this subclass breaks that contract completely!
    throw UnsupportedError(
      "Withdrawals are not allowed on a Fixed Deposit Account until maturity!",
    );
  }
}
