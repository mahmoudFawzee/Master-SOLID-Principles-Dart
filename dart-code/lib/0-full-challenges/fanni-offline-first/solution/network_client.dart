abstract interface class NetworkClient {
  void sendPayload(String endpoint, String body);
}

// Low-Level Detail
class NativeNetworkClient implements NetworkClient {
  @override
  void sendPayload(String endpoint, String body) {
    print(
      "Sending encrypted bytes to $endpoint -> Content-Length: ${body.length}",
    );
  }
}
