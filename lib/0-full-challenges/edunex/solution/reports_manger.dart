import '/0-full-challenges/edunex/solution/local_storage.dart';

abstract interface class ReportsManger {
  void saveReportsToDisk(String reportData);
}

final class GradingReportImpl implements ReportsManger {
  final LocalStorage _db;
  const GradingReportImpl(this._db);
  @override
  void saveReportsToDisk(String reportData) {
    _db.writeEncryptedString("grading_report_key", reportData);
  }
}
