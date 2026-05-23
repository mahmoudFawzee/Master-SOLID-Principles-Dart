import '/0-full-challenges/edunex/solution/models.dart';

abstract interface class SubmittingExamsManger {
  void submitExam(
    String studentId,
    String examType,
    Map<String, dynamic> answers,
  );
}

abstract interface class StreamRole {
  void activeStream(CourseVideo video);
}

abstract interface class VideoPlaybackActivation {
  void activateStream(CourseVideo video, StreamRole role);
}

abstract interface class VideoPlaybackOperation {
  void updateVideo(CourseVideo video, String role);
  void deleteVideo(CourseVideo video, String role);
}

final class UserStreaming implements VideoPlaybackActivation {
  @override
  void activateStream(CourseVideo video, StreamRole role) =>
      role.activeStream(video);
}

final class SysAdminStreaming
    implements VideoPlaybackOperation, VideoPlaybackActivation {
  @override
  void activateStream(CourseVideo video, StreamRole role) =>
      role.activeStream(video);

  @override
  void deleteVideo(CourseVideo video, String role) => print("delete video");

  @override
  void updateVideo(CourseVideo video, String role) => print("update video");
}
