// Concrete Document Class
import '/0-full-challenges/fanni/solution/back_up_manger.dart';
import '/0-full-challenges/fanni/solution/http_client.dart';
import '/0-full-challenges/fanni/solution/invoice_manger.dart';
import '/0-full-challenges/fanni/solution/repair_manger.dart';
import '/0-full-challenges/fanni/solution/technician_payout.dart';

void main() {
  final repairManger = RepairJobsMangerImpl();
  final invoiceManger = InvoiceMangerImpl();
  final httpClient = LocalHttpClient();
  final backUpManger = BackUpMangerImpl(repairManger, httpClient);
  final technicianPayout = TechnicianPayoutImpl(repairManger);
  // Setup sample data
  repairManger.addRepairJob("Screen Replacement", 1500.0, "Ahmed", "completed");
  repairManger.addRepairJob("Battery Diagnostics", 500.0, "Mostafa", "pending");

  // Calculate payouts
  final ahmedPayout = technicianPayout.calculateTechnicianPayout(
    "Ahmed",
    MasterDiscount(),
  );
  print("Ahmed Payout: $ahmedPayout EGP");

  // Sync data
  backUpManger.syncDataToCloud();

  // CRASH RISK (LSP/ISP Violation):
  // Trying to process the pending job throws an unhandled exception!
  final pendingJob = {
    'type': "Battery Diagnostics",
    'cost': 500.0,
    'tech': "Mostafa",
    'status': "pending",
  };
  final invoice = invoiceManger.generateCustomerCompletedJobInvoice(pendingJob);
  print(invoice.toString());
}
