import '/0-full-challenges/edunex/solution/grade_exam_manger.dart';
import '/0-full-challenges/edunex/solution/models.dart';
import '/0-full-challenges/edunex/solution/roles_manger.dart';

final class Student implements StreamRole, SubmittingExamsManger {
  final GradeExamManger _gradeExamManger;
  const Student(this._gradeExamManger);
  @override
  void activeStream(CourseVideo video) =>
      print("Streaming stream path activated for student channel.");

  @override
  void submitExam(
    String studentId,
    String examType,
    Map<String, dynamic> answers,
  ) {
    _gradeExamManger.examSubmissions.add(
      ExamSubmission(studentId: studentId, answers: answers),
    );
    print("إشعار: تم استقبال إجابات الطالب $studentId بنجاح.");
  }
}
