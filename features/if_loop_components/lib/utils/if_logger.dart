import 'dart:developer' as developer;

class IFLogger {
  // Define log levels
  static const String DEBUG = 'DEBUG';
  static const String INFO = 'INFO';
  static const String WARN = 'WARN';
  static const String ERROR = 'ERROR';

  static void info({required dynamic message, String tag = "APP"}) {
    String formattedMessage = '[${DateTime.now()}] [$tag] [$INFO]: $message';
    developer.log(formattedMessage, name: tag, level: _getLogLevel(INFO));
  }

  static void debug({required dynamic message, String tag = "APP"}) {
    String formattedMessage = '[${DateTime.now()}] [$tag] [$DEBUG]: $message';
    developer.log(formattedMessage, name: tag, level: _getLogLevel(DEBUG));
  }

  static void warn({required dynamic message, String tag = "APP"}) {
    String formattedMessage = '[${DateTime.now()}] [$tag] [$WARN]: $message';
    developer.log(formattedMessage, name: tag, level: _getLogLevel(WARN));
  }

  static void error({required dynamic message, String tag = "APP"}) {
    String formattedMessage = '[${DateTime.now()}] [$tag] [$ERROR]: $message';
    developer.log(formattedMessage, name: tag, level: _getLogLevel(ERROR));
  }

  static void newLine() {
    developer.log('\n', level: _getLogLevel(INFO));
  }

  // Custom log function
  static void _log(
    String message, {
    String tag = 'APP',
    String level = INFO,
  }) {
    // Add timestamp, tag, and log level
    String formattedMessage = '[${DateTime.now()}] [$tag] [$level]: $message';

    // Print with specific colors for different levels
    switch (level) {
      case DEBUG:
        print('\x1B[37m$formattedMessage\x1B[0m'); // Gray for DEBUG
        break;
      case INFO:
        print('\x1B[32m$formattedMessage\x1B[0m'); // Green for INFO
        break;
      case WARN:
        print('\x1B[33m$formattedMessage\x1B[0m'); // Yellow for WARN
        break;
      case ERROR:
        print('\x1B[31m$formattedMessage\x1B[0m'); // Red for ERROR
        break;
      default:
        print(formattedMessage); // Default color
    }

    // Optional: Use Dart's developer log for IDE debugging
    developer.log(formattedMessage, name: tag, level: _getLogLevel(level));
  }

  // Map string log levels to Dart's developer log levels
  static int _getLogLevel(String level) {
    switch (level) {
      case DEBUG:
        return 500; // Custom value for DEBUG
      case INFO:
        return 800; // INFO
      case WARN:
        return 900; // WARNING
      case ERROR:
        return 1000; // ERROR
      default:
        return 800; // Default to INFO
    }
  }
}
