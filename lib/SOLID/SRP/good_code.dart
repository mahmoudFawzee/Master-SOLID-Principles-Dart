final class SystemMain {
  final DataBaseManger _dataBaseManger;
  final ReportsManger _reportsManger;
  final InvoiceManager _invoiceManager;
  const SystemMain(
    this._dataBaseManger,
    this._invoiceManager,
    this._reportsManger,
  );
  void run(String id, double amount) {
    final invoice = _invoiceManager.createInvoice(id, amount);
    if (invoice != null) {
      _dataBaseManger.saveToDatabase(invoice);
      _reportsManger.generatePdfReport(invoice);
    }
  }
}

class Invoice {
  final String id;
  final double amount;

  Invoice({required this.id, required this.amount});
}

final class InvoiceManager {
  final List<Invoice> _invoices = [];

  // 1. Business Logic
  Invoice? createInvoice(String id, double amount) {
    final invoice = Invoice(id: id, amount: amount);
    _invoices.add(invoice);
    print("Invoice $id created locally.");
    return invoice;
  }
}

final class DataBaseManger {
  void saveToDatabase(Invoice invoice) {
    // Simulating database connection and insertion
    print("Saving invoice ${invoice.id} to MongoDB...");
  }
}

final class ReportsManger {
  void generatePdfReport(Invoice invoice) {
    // Simulating PDF generation layout and printing
    print("Generating PDF report for invoice ${invoice.id}...");
    print(
      "--- PDF Content: Invoice ID: ${invoice.id} | Total: \$${invoice.amount} ---",
    );
  }
}
