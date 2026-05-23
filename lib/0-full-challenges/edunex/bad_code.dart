// Concrete media item
class CourseVideo {
  final String videoId;
  final String title;
  CourseVideo(this.videoId, this.title);
}

// THE MONOLITHIC MONSTER: Violates S, O, L, I, and D simultaneously!
class EdunexPlatformEngine {
  final List<Map<String, dynamic>> _examSubmissions = [];

  // 1. Violates SRP: Manages state, handles console logging, and mixes domain boundaries
  void submitExam(
    String studentId,
    String examType,
    Map<String, dynamic> answers,
  ) {
    _examSubmissions.add({
      'studentId': studentId,
      'type': examType,
      'answers': answers,
      'graded': false,
      'score': 0.0,
    });
    print("إشعار: تم استقبال إجابات الطالب $studentId بنجاح.");
  }

  // 2. Violates OCP & LSP: Fragile type parsing, hardcoded business logic strings,
  // and explicit runtime crashes if a new unhandled type is introduced.
  double gradeExam(Map<String, dynamic> submission) {
    final type = submission['type'] as String;
    final answers = submission['answers'] as Map<String, dynamic>;

    if (type == 'MultipleChoice') {
      // Basic count grading
      return answers.values.where((v) => v == true).length * 5.0;
    } else if (type == 'AiTextEssay') {
      // Direct instantiation of a low-level detail service (Violates DIP)
      final aiEvaluator = GeminiAIEvaluator();
      final arabicText = answers['essay_raw'] as String;
      return aiEvaluator.analyzeArabicGrammarAndContext(arabicText);
    } else if (type == 'TeacherReviewRequired') {
      // Violates LSP: Subversive runtime crash!
      // This method promises to return a double score immediately, but it blows up
      // because manual reviews require waiting for an asynchronous human teacher action.
      throw UnsupportedError(
        "ERROR: Cannot instantly auto-grade a manual teacher review exam!",
      );
    }

    return 0.0;
  }

  // 3. Violates ISP: Forcing a generic student client profile to interact with
  // administration streaming tools and configuration overrides they shouldn't touch.
  void authorizeVideoPlayback(CourseVideo video, String userRole) {
    print("Checking playback security headers for video: ${video.title}");

    if (userRole == 'Student') {
      print("Streaming stream path activated for student channel.");
    } else if (userRole == 'Teacher') {
      print(
        "Stream activated with administrative timeline overlay widgets enabled.",
      );
    } else if (userRole == 'SysAdmin') {
      // Admins can delete or override video metadata inside a playback call!
      print(
        "WARNING: Root system configuration accessed inside playback channel.",
      );
    }
  }

  // 4. Violates DIP: Tied to a concrete, non-abstracted local storage client
  void saveGradingReportToDisk(String reportData) {
    final db =
        HiveLocalStorage(); // Hardcoded low-level storage framework dependency!
    db.writeEncryptedString("grading_report_key", reportData);
  }
}

// Low-Level Detail 1
class GeminiAIEvaluator {
  double analyzeArabicGrammarAndContext(String text) {
    print(
      "Running AI natural language processing for Arabic script analysis...",
    );
    return text.contains("أحسنت") ? 100.0 : 85.0;
  }
}

// Low-Level Detail 2
class HiveLocalStorage {
  void writeEncryptedString(String key, String value) {
    print("Securely saved payload to local Hive box storage index [$key]");
  }
}

void main() {
  final engine = EdunexPlatformEngine();

  // Setup multiple exam types
  engine.submitExam("std_101", "MultipleChoice", {"q1": true, "q2": false});
  engine.submitExam("std_102", "AiTextEssay", {
    "essay_raw": "البلاغة هي الإيجاز في الكلام وأحسنت التعبير",
  });

  // Test case 1: MCQ works
  final mcqScore = engine.gradeExam({
    'type': 'MultipleChoice',
    'answers': {"q1": true, "q2": false},
  });
  print("MCQ Calculated Score: $mcqScore");

  // Test case 2: AI grading works
  final aiScore = engine.gradeExam({
    'type': 'AiTextEssay',
    'answers': {"essay_raw": "أحسنت التعبير"},
  });
  print("AI Evaluated Score: $aiScore");

  // CRASH RISK ZONE:
  final pendingManualSubmission = {
    'type': 'TeacherReviewRequired',
    'answers': {"written_work": "..."},
  };
  engine.gradeExam(pendingManualSubmission); // Boom! Exception thrown.
}
