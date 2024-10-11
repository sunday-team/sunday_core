// Class definition
import 'dart:async';

import 'package:get_storage/get_storage.dart';

class SundayGetStorage {
  final String? storageName;
  final GetStorage box;
  Function? disposeListen;

  SundayGetStorage({this.storageName}) : box = GetStorage(storageName ?? '');

  // Function to read a value from storage
  Future<T?> read<T>(String key) async {
    return box.read(key);
  }

  // Function to write a value to storage
  Future<void> write(String key, dynamic value) async {
    box.write(key, value);
  }

  // Function to remove a value from storage
  Future<void> remove(String key) async {
    box.remove(key);
  }

  // Function to listen for changes in the storage
  void listenBox() {
    disposeListen = box.listen(() {
      print('box changed');
    });
  }

  // Function to dispose of the listener
  void disposeListener() {
    disposeListen?.call();
  }

  void erase() {
    box.erase();
  }

  // Function to initialize a specific container
  Future<void> init({String? storageName}) async {
    await GetStorage.init(storageName ?? '');
  }

  // Function to create a new storage container
  SundayGetStorage createStorage({String? storageName}) {
    return SundayGetStorage(storageName: storageName);
  }

  // Function to get a stream of changes for a specific key
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