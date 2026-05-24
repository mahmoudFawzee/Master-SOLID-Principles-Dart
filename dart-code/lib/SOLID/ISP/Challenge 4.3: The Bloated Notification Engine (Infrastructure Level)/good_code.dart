abstract interface class TextNotificationService {
  void sendText(String recipient, String message);
}

abstract interface class RichMediaNotificationService {
  void attachImage(String imageUrl);
  void addActionButton(String label, String deepLink);
}

class SmsNotificationChannel implements TextNotificationService {
  @override
  void sendText(String recipient, String message) {
    print("Sending SMS to $recipient: $message");
  }
}

class RichMediaNotificationChannel implements RichMediaNotificationService {
  @override
  void attachImage(String imageUrl) => print('attach images: $imageUrl');

  @override
  void addActionButton(String label, String deepLink) =>
      print('add $label button: $deepLink');
}
