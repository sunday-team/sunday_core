library sunday_core;

import 'package:sunday_core/GetGtorage/get_storage.dart';

/// SundayCore is a class that contains all the core functionality of the Sunday platform.
class SundayCore {
  /// init SundayCore
  static Future<void> init() async {
    await SundayGetStorage().init();
  }
}
