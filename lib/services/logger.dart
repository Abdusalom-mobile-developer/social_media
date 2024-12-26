import 'package:logger/logger.dart';

class LoggerService {
  static final Logger _logger = Logger();

  static void d(String message) {
    _logger.d(message);
  }

   static void e(String message) {
    _logger.e(message);
  }
}
