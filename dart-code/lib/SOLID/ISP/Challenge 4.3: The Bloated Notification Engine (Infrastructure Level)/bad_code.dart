abstract interface class NotificationService {
  void sendText(String recipient, String message);
  void attachImage(String imageUrl);
  void addActionButton(String label, String deepLink);
}

// SMS cannot support rich media!
class SmsNotificationChannel implements NotificationService {
  @override
  void sendText(String recipient, String message) {
    print("Sending SMS to $recipient: $message");
  }

  // VIOLATION: Forced to implement useless methods that break or do nothing
  @override
  void attachImage(String imageUrl) {
    throw UnsupportedError("SMS channels do not support rich media images!");
  }

  @override
  void addActionButton(String label, String deepLink) {
    throw UnsupportedError(
      "SMS channels do not support interactive UI buttons!",
    );
  }
}
