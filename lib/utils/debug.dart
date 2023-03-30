import 'package:flutter/foundation.dart';

class DebugUtil {
  static void dump(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }
}
