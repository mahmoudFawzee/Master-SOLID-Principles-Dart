// Concrete media item
class CourseVideo {
  final String videoId;
  final String title;
  CourseVideo(this.videoId, this.title);
}

class ExamSubmission {
  final String studentId;
  final Map<String, dynamic> answers;
  final bool graded;
  final double score;
  const ExamSubmission({
    required this.studentId,
    required this.answers,
    this.score = 0.0,
    this.graded = false,
  });
}
