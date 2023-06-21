import 'package:logger/logger.dart';

class LogManager {
  static final LogManager _instance = LogManager._internal();

  factory LogManager() => _instance;

  late Logger _logger;

  LogManager._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        printTime: true, // 可以自定义打印器的选项
      ),
    );
  }

  void logInfo(String message) {
    _logger.i(message);
  }

  void logError(var message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }

  void logDebug(var message) {
    _logger.d(message);
  }

}
