import 'package:logger/logger.dart';

class LoggerUtils {
  static final LoggerUtils _instance = LoggerUtils._internal();
  factory LoggerUtils() => _instance;
  late Logger _logger;

  LoggerUtils._internal() {
    _logger = Logger(
      filter: null,
      printer: PrettyPrinter(methodCount: 0),
      output: null,
    );
  }

  Logger get() => _logger;
}
