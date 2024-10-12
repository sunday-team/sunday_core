import 'package:flutter/foundation.dart';

/// A utility function to print text in the console during debug mode.
///
/// This function wraps the standard [print] function with a debug mode check,
/// ensuring that print statements are only executed in debug builds.
///
/// [text] The dynamic content to be printed. Can be of any type.
///
/// Example:
/// ```dart
/// sundayPrint('Debug message');
/// sundayPrint({'key': 'value'});
/// ```
void sundayPrint(dynamic text) {
  if (kDebugMode) {
    print(text);
  }
}
