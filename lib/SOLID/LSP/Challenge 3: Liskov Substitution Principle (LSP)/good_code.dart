// 1. The highest level contract: Everything can receive money
abstract class Account {
  double _balance = 0;
  double get balance => _balance;

  void deposit(double amount) {
    _balance += amount;
    print("Deposited \$$amount. New balance: \$$_balance");
  }
}

// 2. A specialized contract for accounts that allow money to be taken out
abstract class WithdrawableAccount extends Account {
  void withdraw(double amount);
}

// 3. Implements the specific withdrawable behavior
class SavingsAccount extends WithdrawableAccount {
  @override
  void withdraw(double amount) {
    if (balance >= amount) {
      _balance -= amount;
      print("Withdrew \$$amount. New balance: \$$balance");
    } else {
      print("Insufficient funds.");
    }
  }
}

// 4. Implements ONLY what it safely supports. No hidden exceptions!
class FixedDepositAccount extends Account {
  void matureAndTransferTo(WithdrawableAccount targetAccount) {
    print("Maturity reached! Transferring \$$balance...");
    targetAccount.deposit(balance);
    _balance = 0;
  }
}
