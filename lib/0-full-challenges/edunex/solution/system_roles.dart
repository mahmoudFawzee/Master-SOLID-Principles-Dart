import '/0-full-challenges/edunex/solution/models.dart';
import '/0-full-challenges/edunex/solution/roles_manger.dart';

final class SystemAdmin implements StreamRole {
  @override
  void activeStream(CourseVideo video) => print(
    "Stream activated with system admin timeline overlay widgets enabled.",
  );
}
