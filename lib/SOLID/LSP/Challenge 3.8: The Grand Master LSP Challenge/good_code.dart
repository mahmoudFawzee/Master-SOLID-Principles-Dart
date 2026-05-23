// 1. A clean, independent contract for specialized language processors
abstract interface class LanguageProcessor {
  List<String> extract(String rawTranscript);
}

// 2. This class ONLY focuses on Arabic. It doesn't pretend to handle English.
class ArabicRetailVoiceProcessor implements LanguageProcessor {
  @override
  List<String> extract(String rawTranscript) {
    if (rawTranscript.startsWith("فني")) {
      return ["تحديث", "المخزون"];
    }
    return ["غير", "معروف"]; // Returns Arabic for "Unknown"
  }
}

// 3. This class ONLY focuses on English.
class EnglishVoiceProcessor implements LanguageProcessor {
  @override
  List<String> extract(String rawTranscript) {
    return rawTranscript.toLowerCase().split(' ');
  }
}

// 4. The Orchestrator that determines which strategy to use
class VoiceCommandRouter {
  final LanguageProcessor englishProcessor;
  final LanguageProcessor arabicProcessor;

  VoiceCommandRouter({
    required this.arabicProcessor,
    required this.englishProcessor,
  });

  List<String> process(String rawTranscript) {
    // Check script type here at the routing level, NOT inside the subclass
    if (rawTranscript.contains(RegExp(r'[\u0600-\u06FF]'))) {
      return arabicProcessor.extract(rawTranscript);
    } else {
      return englishProcessor.extract(rawTranscript);
    }
  }
}

void main() {
  final voiceCommandRouter = VoiceCommandRouter(
    englishProcessor: EnglishVoiceProcessor(),
    arabicProcessor: ArabicRetailVoiceProcessor(),
  );

  print(voiceCommandRouter.process('raw Transcript'));
  print(voiceCommandRouter.process('فني اهو اي كلام'));
}
