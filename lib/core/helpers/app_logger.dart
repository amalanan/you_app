import 'package:flutter/foundation.dart';

abstract final class AppLogger {
  static void d(Object? message) {
    if (kDebugMode) debugPrint('[YOU] $message');
  }
}
