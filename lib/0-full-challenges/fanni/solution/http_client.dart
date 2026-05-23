abstract interface class HttpClient {
  void postData(String url, String body);
}

class LocalHttpClient implements HttpClient {
  @override
  void postData(String url, String body) {
    print("HTTP POST to $url with payload length: ${body.length}");
  }
}
