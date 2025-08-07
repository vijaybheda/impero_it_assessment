import 'dart:developer' as d;

class Logger {
  Logger._internal();

  static final Logger _instance = Logger._internal();

  factory Logger() {
    return _instance;
  }

  static void log(dynamic message) {
    final timestamp = DateTime.now().toLocal();
    final formattedMessage = '[$timestamp] $message';
    d.log(formattedMessage);
  }

  static void error(dynamic message, [StackTrace? stackTrace]) {
    final timestamp = DateTime.now().toLocal();
    final formattedMessage = '[$timestamp] $message';
    d.log(formattedMessage);
    if (stackTrace != null) {
      d.log(stackTrace.toString());
    }
  }
}
