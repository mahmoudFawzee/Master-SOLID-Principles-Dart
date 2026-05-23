
// Concrete Document Class
class InvoicePdf {
  final String content;
  InvoicePdf(this.content);
  void saveToFile(String path) => print("Saving PDF file to $path");
}

// THE MONOLITHIC MASS: Violates S, O, L, I, and D!
class WorkshopManager {
  final List<Map<String, dynamic>> _repairJobs = [];

  // 1. Violates SRP: Manages state AND handles console printing logic
  void addRepairJob(
    String jobType,
    double cost,
    String technician,
    String status,
  ) {
    _repairJobs.add({
      'type': jobType,
      'cost': cost,
      'tech': technician,
      'status': status,
    });
    print("Job added: $jobType for $technician");
  }

  // 2. Violates OCP: Hardcoded calculation rules.
  // If a 'Senior' tech joins tomorrow, we have to modify this core function.
  double calculateTechnicianPayout(String techName, String rank) {
    double total = 0;
    for (final job in _repairJobs) {
      if (job['tech'] == techName && job['status'] == 'completed') {
        if (rank == 'Junior') {
          total += (job['cost'] as double) * 0.40; // 40% cut
        } else if (rank == 'Master') {
          total += (job['cost'] as double) * 0.60; // 60% cut
        }
      }
    }
    return total;
  }

  // 3. Violates LSP & ISP: Forces a rigid structure that can crash at runtime.
  // Generates invoices but blows up if a job is incomplete.
  InvoicePdf generateCustomerInvoice(Map<String, dynamic> job) {
    if (job['status'] != 'completed') {
      // Violates LSP: Subverting expectations by throwing an operational crash error
      throw UnsupportedError(
        "Cannot generate invoice for active or cancelled jobs!",
      );
    }

    final invoiceData = "INVOICE: ${job['type']} | Total: ${job['cost']} EGP";
    return InvoicePdf(invoiceData);
  }

  // 4. Violates DIP: Directly instantiates a concrete, hardcoded HTTP client dependency
  void syncDataToCloud() {
    print("Initializing direct connection to Cloud API...");
    final client = LocalHttpClient(); // Hardcoded low-level detail!
    client.postData("https://api.fanni-app.eg/sync", _repairJobs.toString());
  }
}

// Low-level HTTP Client Detail
class LocalHttpClient {
  void postData(String url, String body) {
    print("HTTP POST to $url with payload length: ${body.length}");
  }
}

void main() {
  final manager = WorkshopManager();

  // Setup sample data
  manager.addRepairJob("Screen Replacement", 1500.0, "Ahmed", "completed");
  manager.addRepairJob("Battery Diagnostics", 500.0, "Mostafa", "pending");

  // Calculate payouts
  final ahmedPayout = manager.calculateTechnicianPayout("Ahmed", "Master");
  print("Ahmed Payout: $ahmedPayout EGP");

  // Sync data
  manager.syncDataToCloud();

  // CRASH RISK (LSP/ISP Violation):
  // Trying to process the pending job throws an unhandled exception!
  final pendingJob = {
    'type': "Battery Diagnostics",
    'cost': 500.0,
    'tech': "Mostafa",
    'status': "pending",
  };
  manager.generateCustomerInvoice(pendingJob);
}
