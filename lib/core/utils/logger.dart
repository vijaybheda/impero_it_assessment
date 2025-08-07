import 'dart:developer' as d;

enum LogLevel { debug, info, warning, error }

class Logger {
  Logger._internal();

  static final Logger _instance = Logger._internal();
  static bool _isDebugMode = true; // Set to false in production

  factory Logger() {
    return _instance;
  }

  static void setDebugMode(bool enabled) {
    _isDebugMode = enabled;
  }

  static void log(dynamic message, {LogLevel level = LogLevel.info}) {
    if (!_isDebugMode && level == LogLevel.debug) return;
    
    final timestamp = DateTime.now().toLocal();
    final formattedMessage = '[$timestamp] [$level] $message';
    
    switch (level) {
      case LogLevel.debug:
        d.log(formattedMessage);
        break;
      case LogLevel.info:
        d.log(formattedMessage);
        break;
      case LogLevel.warning:
        d.log(formattedMessage);
        break;
      case LogLevel.error:
        d.log(formattedMessage);
        break;
    }
  }

  static void debug(dynamic message) => log(message, level: LogLevel.debug);
  static void info(dynamic message) => log(message, level: LogLevel.info);
  static void warning(dynamic message) => log(message, level: LogLevel.warning);
  static void error(dynamic message, [StackTrace? stackTrace]) {
    log(message, level: LogLevel.error);
    if (stackTrace != null) {
      log(stackTrace.toString(), level: LogLevel.error);
    }
  }
}
