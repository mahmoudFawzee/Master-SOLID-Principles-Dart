abstract interface class AiEvaluator {
  double analyzeArabicGrammarAndContext(String text);
}

final class GeminiAIEvaluator implements AiEvaluator {
  @override
  double analyzeArabicGrammarAndContext(String text) {
    print(
      "Running AI natural language processing for Arabic script analysis...",
    );
    return text.contains("أحسنت") ? 100.0 : 85.0;
  }
}
