class NullAddressException implements Exception {
  final String message;

  NullAddressException(this.message);

  @override
  String toString() => message;
}
