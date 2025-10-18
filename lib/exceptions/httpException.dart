class Httpexception implements Exception {
  final String msg;
  final int statusCode;

  Httpexception({required this.msg, required this.statusCode});

  @override
  String toString() {
    return msg;
  }
}
