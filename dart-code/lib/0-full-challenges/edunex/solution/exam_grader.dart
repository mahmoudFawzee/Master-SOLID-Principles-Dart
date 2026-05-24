import '/0-full-challenges/edunex/solution/ai_evaluator.dart';
import '/0-full-challenges/edunex/solution/models.dart';

abstract interface class ExamGrader {
  double? gradeExam(ExamSubmission submission);
}

final class MultipleChoice implements ExamGrader {
  @override
  double? gradeExam(ExamSubmission submitting) =>
      submitting.answers.values.where((v) => v == true).length * 5.0;
}

final class AiTextEssay implements ExamGrader {
  final AiEvaluator _aiEvaluator;
  const AiTextEssay(this._aiEvaluator);

  @override
  double? gradeExam(ExamSubmission submitting) {
    final arabicText = submitting.answers['essay_raw'];
    if (arabicText.runtimeType != String) {
      print('This is not string value');
      return null;
    }
    return _aiEvaluator.analyzeArabicGrammarAndContext(arabicText);
  }
}
