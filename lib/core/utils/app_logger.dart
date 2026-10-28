import 'package:flutter/foundation.dart';

/// Logger internal yang otomatis nonaktif pada mode release sesuai AGENTS.md.
abstract final class AppLogger {
  static void info(String message) {
    if (kDebugMode) {
      debugPrint('[INFO] $message');
    }
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message ${error ?? ''}');
      if (stackTrace != null) {
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }
}
