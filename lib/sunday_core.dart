/// The main library for the Sunday Core package.
///
/// This library provides core functionality for the Sunday platform,
/// including initialization and storage management.
library sunday_core;

import 'package:sunday_core/GetGtorage/get_storage.dart';

/// SundayCore is a class that contains all the core functionality of the Sunday platform.
///
/// It provides static methods for initializing the core components of the Sunday platform.
class SundayCore {
  /// Initializes the SundayCore.
  ///
  /// This method should be called before using any other functionality of the Sunday platform.
  /// It initializes the storage system using [SundayGetStorage].
  ///
  /// Returns a [Future] that completes when the initialization is done.
  static Future<void> init() async {
    await SundayGetStorage().init();
  }
}
