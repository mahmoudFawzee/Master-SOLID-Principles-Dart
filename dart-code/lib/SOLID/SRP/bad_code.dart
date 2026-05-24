class Invoice {
  final String id;
  final double amount;

  Invoice({required this.id, required this.amount});
}

class InvoiceManager {
  final List<Invoice> _invoices = [];

  // 1. Business Logic
  void createInvoice(String id, double amount) {
    final invoice = Invoice(id: id, amount: amount);
    _invoices.add(invoice);
    print("Invoice $id created locally.");

    // 2. Persistence Logic packed inside
    _saveToDatabase(invoice);

    // 3. Presentation/Reporting Logic packed inside
    _generatePdfReport(invoice);
  }

  void _saveToDatabase(Invoice invoice) {
    // Simulating database connection and insertion
    print("Saving invoice ${invoice.id} to MongoDB...");
  }

  void _generatePdfReport(Invoice invoice) {
    // Simulating PDF generation layout and printing
    print("Generating PDF report for invoice ${invoice.id}...");
    print(
      "--- PDF Content: Invoice ID: ${invoice.id} | Total: \$${invoice.amount} ---",
    );
  }
}
