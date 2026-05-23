// --- Base Event Hierarchy ---
abstract class Event {
  final DateTime timestamp = DateTime.now();
}

class UserLoggedInEvent extends Event {
  final String userId;
  UserLoggedInEvent(this.userId);
}

class SystemAlertEvent extends Event {
  final String alertMessage;
  SystemAlertEvent(this.alertMessage);
}

// --- Consumer Hierarchy ---
class EventConsumer {
  void consume(Event event) {
    print("Generic event logged at ${event.timestamp}");
  }
}

class AuthEventConsumer extends EventConsumer {
  @override
  void consume(Event event) {
    // VIOLATION: Tightening the acceptable input type via a downcast!
    // The base contract says: "I can safely consume ANY Event."
    // This subclass forces a hidden rule: "If you pass me a non-auth Event, I crash."
    final authEvent = event as UserLoggedInEvent;
    print("User ${authEvent.userId} logged in successfully.");
  }
}

class EventBroker {
  final List<EventConsumer> _consumers = [];

  void registerConsumer(EventConsumer consumer) => _consumers.add(consumer);

  void broadcast(Event event) {
    for (final consumer in _consumers) {
      // The broker treats all consumers uniformly.
      // It assumes every consumer can safely process any object extending Event.
      consumer.consume(event);
    }
  }
}

void main() {
  final broker = EventBroker();

  broker.registerConsumer(EventConsumer());
  broker.registerConsumer(
    AuthEventConsumer(),
  ); // Looks completely valid to the type checker

  // Scenario A: Works beautifully
  broker.broadcast(UserLoggedInEvent("user_99"));

  // Scenario B: CRASHES THE SYSTEM WITH A RUNTIME TYPE ERROR!
  // The system broadcasts a system alert, but AuthEventConsumer tries to cast it
  // to a UserLoggedInEvent, throwing a 'TypeError'.
  broker.broadcast(SystemAlertEvent("Database connection dropped!"));
}
