import '/0-full-challenges/edunex/solution/ai_evaluator.dart';
import '/0-full-challenges/edunex/solution/exam_grader.dart';
import '/0-full-challenges/edunex/solution/grade_exam_manger.dart';
import '/0-full-challenges/edunex/solution/models.dart';
import '/0-full-challenges/edunex/solution/student.dart';
import '/0-full-challenges/edunex/solution/teacher.dart';

void main() {
  final engine = GradeExamManger();
  final aiEvaluator = GeminiAIEvaluator();
  final studentController = Student(engine);

  // Setup multiple exam types
  studentController.submitExam("std_101", "MultipleChoice", {
    "q1": true,
    "q2": false,
  });
  studentController.submitExam("std_102", "AiTextEssay", {
    "essay_raw": "البلاغة هي الإيجاز في الكلام وأحسنت التعبير",
  });

  // Test case 1: MCQ works
  final mcqScore = engine.gradeExam(
    ExamSubmission(studentId: 'studentId', answers: {"q1": true, "q2": false}),
    MultipleChoice(),
  );
  print("MCQ Calculated Score: $mcqScore");

  // Test case 2: AI grading works
  final aiScore = engine.gradeExam(
    ExamSubmission(studentId: '', answers: {"essay_raw": "أحسنت التعبير"}),
    AiTextEssay(aiEvaluator),
  );
  print("AI Evaluated Score: $aiScore");

  // CRASH RISK ZONE:
  engine.gradeExam(
    ExamSubmission(studentId: 'studentId', answers: {"written_work": "..."}),
    Teacher(),
  ); // Boom! Exception thrown.
}
