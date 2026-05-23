import '/0-full-challenges/edunex/solution/exam_grader.dart';
import '/0-full-challenges/edunex/solution/models.dart';

final class GradeExamManger {
  final List<ExamSubmission> _examSubmissions = [];

  List<ExamSubmission> get examSubmissions => _examSubmissions;
  double? gradeExam(ExamSubmission submission, ExamGrader grader) =>
      grader.gradeExam(submission);
}
