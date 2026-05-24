import '/0-full-challenges/fanni/solution/repair_manger.dart';

abstract interface class TechnicianPayout {
  double calculateTechnicianPayout(
    String techName,
    DiscountSeniorityRankBased rank,
  );
}

abstract class DiscountSeniorityRankBased {
  double calculateDiscountPayout(double preCost);
}

final class JuniorDiscount implements DiscountSeniorityRankBased {
  @override
  double calculateDiscountPayout(double preCost) => preCost * 0.40;
}

final class MasterDiscount implements DiscountSeniorityRankBased {
  @override
  double calculateDiscountPayout(double preCost) => preCost * 0.60;
}

final class TechnicianPayoutImpl implements TechnicianPayout {
  final RepairManger _repairManger;
  const TechnicianPayoutImpl(this._repairManger);
  @override
  double calculateTechnicianPayout(
    String techName,
    DiscountSeniorityRankBased rank,
  ) {
    double total = 0;
    for (final job in _repairManger.repairJobsList) {
      if (job.technician == techName && job.status == 'completed') {
        final preCost = job.cost;
        total += rank.calculateDiscountPayout(preCost);
      }
    }
    return total;
  }
}
