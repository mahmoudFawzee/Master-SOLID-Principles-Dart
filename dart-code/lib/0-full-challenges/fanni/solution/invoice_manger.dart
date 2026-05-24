import '/0-full-challenges/fanni/solution/invoice_pdf_model.dart';

abstract interface class InvoiceManger {
  InvoicePdf? generateCustomerCompletedJobInvoice(Map<String, dynamic> job);
}

final class InvoiceMangerImpl implements InvoiceManger {
  @override
  InvoicePdf? generateCustomerCompletedJobInvoice(Map<String, dynamic> job) {
    if (job['status'] != 'completed') {
      return null;
    }

    final invoiceData = "INVOICE: ${job['type']} | Total: ${job['cost']} EGP";
    return InvoicePdf(invoiceData);
  }
}
