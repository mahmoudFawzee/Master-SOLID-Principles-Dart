class VoiceCommandProcessor {
  /// Precondition: Accepts any non-null string command.
  /// Postcondition: Guarantees returning a List of lowercase action words.
  List<String> extractKeywords(String rawTranscript) {
    if (rawTranscript.trim().isEmpty) return [];
    return rawTranscript.toLowerCase().split(' ');
  }
}

class ArabicRetailVoiceProcessor extends VoiceCommandProcessor {
  @override
  List<String> extractKeywords(String rawTranscript) {
    // Trap 1: Tightening Preconditions
    if (!rawTranscript.contains(RegExp(r'[\u0600-\u06FF]'))) {
      throw ArgumentError("This processor only accepts Arabic script text!");
    }

    // Trap 2: Weakening Postconditions
    // Instead of filtering words or returning an empty list when nothing matches,
    // it abruptly returns null, violating the guaranteed List type promise.
    if (rawTranscript.startsWith("فني")) {
      return ["تحديث", "المخزون"];
    }

    // Explicitly returning dynamic null option down the road
    return [];
  }
}
