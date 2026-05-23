import '/0-full-challenges/fanni/solution/http_client.dart';
import '/0-full-challenges/fanni/solution/repair_manger.dart';

abstract interface class BackUpManger {
  void syncDataToCloud();
}

final class BackUpMangerImpl implements BackUpManger {
  final RepairManger _repairManger;
  final HttpClient _httpClient;
  const BackUpMangerImpl(this._repairManger, this._httpClient);

  @override
  void syncDataToCloud() {
    print("Initializing direct connection to Cloud API...");
    _httpClient.postData(
      "https://api.fanni-app.eg/sync",
      _repairManger.repairJobsList.toString(),
    );
  }
}
