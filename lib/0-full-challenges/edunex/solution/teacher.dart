import '/0-full-challenges/edunex/solution/exam_grader.dart';
import '/0-full-challenges/edunex/solution/models.dart';
import '/0-full-challenges/edunex/solution/roles_manger.dart';

final class Teacher implements StreamRole, ExamGrader {
  @override
  void activeStream(CourseVideo video) => print(
    "Stream activated with administrative timeline overlay widgets enabled.",
  );
  @override
  double? gradeExam(ExamSubmission submission) {
    print('Cannot instantly auto-grade a manual teacher review exam!');
    return null;
  }
}
