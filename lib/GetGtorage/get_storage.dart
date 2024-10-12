import 'dart:async';

import 'package:get_storage/get_storage.dart';

/// A wrapper class for GetStorage providing additional functionality
class SundayGetStorage {
  /// The name of the storage container
  final String? storageName;

  /// The GetStorage instance
  final GetStorage box;

  /// Function to dispose of the listener
  Function? disposeListen;

  /// Creates a new instance of SundayGetStorage
  ///
  /// [storageName] is an optional parameter to specify the name of the storage container
  SundayGetStorage({this.storageName}) : box = GetStorage(storageName ?? '');

  /// Reads a value from storage
  ///
  /// [key] is the key of the value to be read
  /// Returns a Future that completes with the value of type T, or null if not found
  Future<T?> read<T>(String key) async {
    return box.read(key);
  }

  /// Writes a value to storage
  ///
  /// [key] is the key under which the value will be stored
  /// [value] is the value to be stored
  Future<void> write(String key, dynamic value) async {
    box.write(key, value);
  }

  /// Removes a value from storage
  ///
  /// [key] is the key of the value to be removed
  Future<void> remove(String key) async {
    box.remove(key);
  }

  /// Listens for changes in the storage
  void listenBox() {
    disposeListen = box.listen(() {
      print('box changed');
    });
  }

  /// Disposes of the listener
  void disposeListener() {
    disposeListen?.call();
  }

  /// Erases all data in the storage
  void erase() {
    box.erase();
  }

  /// Initializes a specific storage container
  ///
  /// [storageName] is an optional parameter to specify the name of the storage container
  Future<void> init({String? storageName}) async {
    await GetStorage.init(storageName ?? '');
  }

  /// Creates a new storage container
  ///
  /// [storageName] is an optional parameter to specify the name of the new storage container
  /// Returns a new instance of SundayGetStorage
  SundayGetStorage createStorage({String? storageName}) {
    return SundayGetStorage(storageName: storageName);
  }

  /// Gets a stream of changes for a specific key
  ///
  /// [key] is the key to listen for changes
  /// Returns a Stream that emits the new value whenever it changes
  Stream<T?> listenKey<T>(String key) {
    final controller = StreamController<T?>();
    disposeListen = box.listen(() {
      controller.add(box.read<T>(key));
    });

    // Ensure the stream controller is closed when the stream is no longer in use
    controller.onCancel = () {
      disposeListen?.call();
      controller.close();
    };

    return controller.stream;
  }

  /// Gets a stream of changes for a specific key using GetStorage's listenKey method
  ///
  /// [key] is the key to listen for changes
  /// Returns a Stream that emits the new value whenever it changes
  Stream<T?> streamUsingKey<T>(String key) {
    final controller = StreamController<T?>();
    disposeListen = box.listenKey(key, (value) {
      controller.add(value as T?);
    });

    // Ensure the stream controller is closed when the stream is no longer in use
    controller.onCancel = () {
      disposeListen?.call();
      controller.close();
    };

    return controller.stream;
  }
}
