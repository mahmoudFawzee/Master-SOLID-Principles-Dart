final class JobModel {
  final String jobType;
  final double cost;
  final String technician;
  final String status;
  const JobModel({
    required this.jobType,
    required this.cost,
    required this.technician,
    required this.status,
  });
}

abstract interface class RepairManger {
  List<JobModel> get repairJobsList;
  void addRepairJob(
    String jobType,
    double cost,
    String technician,
    String status,
  );
}

final class RepairJobsMangerImpl implements RepairManger {
  final List<JobModel> _repairJobs = [];
  @override
  List<JobModel> get repairJobsList => _repairJobs;
  @override
  void addRepairJob(
    String jobType,
    double cost,
    String technician,
    String status,
  ) {
    _repairJobs.add(
      JobModel(
        jobType: jobType,
        cost: cost,
        technician: technician,
        status: status,
      ),
    );
    print("Job added: $jobType for $technician");
  }
}
