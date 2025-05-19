import 'package:logger/logger.dart';

class Log {
  static final Logger _instance = Logger();

  static void info(message, [Object? error, StackTrace? stackTrace]) {
    _instance.i(message, error: error, stackTrace: stackTrace);
  }

  static void warning(message, [Object? error, StackTrace? stackTrace]) {
    _instance.w(message, error: error, stackTrace: stackTrace);
  }

  static void error(message, [Object? error, StackTrace? stackTrace]) {
    _instance.e(message, error: error, stackTrace: stackTrace);
  }
}
