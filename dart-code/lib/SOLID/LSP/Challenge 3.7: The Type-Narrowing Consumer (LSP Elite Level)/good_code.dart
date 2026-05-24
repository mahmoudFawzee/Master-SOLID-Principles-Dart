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
abstract interface class EventConsumer<T extends Event> {
  void consume(T event);
  bool canHandle(Event event);
}

class AuthEventConsumer extends EventConsumer<UserLoggedInEvent> {
  @override
  void consume(UserLoggedInEvent event) {
    print("User ${event.userId} logged in successfully.");
  }

  @override
  bool canHandle(Event event) => event is UserLoggedInEvent;
}

class SystemEventConsumer extends EventConsumer<SystemAlertEvent> {
  @override
  void consume(SystemAlertEvent event) {
    print("User ${event.alertMessage} logged in successfully.");
  }

  @override
  bool canHandle(Event event) => event is SystemAlertEvent;
}

class EventBroker {
  final List<EventConsumer> _consumers = [];

  void registerConsumer(EventConsumer consumer) => _consumers.add(consumer);

  void broadcast(Event event) {
    for (final consumer in _consumers) {
      // The broker treats all consumers uniformly.
      // It assumes every consumer can safely process any object extending Event.
      if (consumer.canHandle(event)) {
        consumer.consume(event);
      }
    }
  }
}

void main() {
  final broker = EventBroker();

  //broker.registerConsumer(EventConsumer());
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
