import 'dart:io';
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:sunday_core/GetGtorage/get_storage.dart';
import 'package:sunday_core/sunday_core.dart';
import 'package:sunday_core/Print/print.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class MockPathProvider extends PathProviderPlatform {
  final Directory tempDir;

  MockPathProvider(this.tempDir);

  @override
  Future<String> getApplicationDocumentsPath() async {
    return tempDir.path;
  }

  // Implement other methods if needed
}

void main() {
  Directory tempDir;

  setUpAll(() async {
    // Create a temporary directory
    tempDir = await Directory.systemTemp.createTemp();

    // Register the mock path provider
    PathProviderPlatform.instance = MockPathProvider(tempDir);
  });

  group('SundayGetStorage Tests', () {
    test('Verify that the storage is initialized', () async {
      await SundayGetStorage().init();
      // Verify by performing a simple write and read operation
      final storage = SundayGetStorage();
      await storage.write('init_test_key', 'init_test_value');
      final result = await storage.read<String>('init_test_key');
      expect(result, 'init_test_value');
    });

    test('Write and read from storage', () async {
      final storage = SundayGetStorage();
      await storage.write('key', 'value');
      final result = await storage.read<String>('key');
      expect(result, 'value');
    });

    test('Remove from storage', () async {
      final storage = SundayGetStorage();
      await storage.write('key', 'value');
      await storage.remove('key');
      final result = await storage.read<String>('key');
      expect(result, isNull);
    });

    test('Erase storage', () async {
      final storage = SundayGetStorage();
      await storage.write('key', 'value');
      storage.erase();
      final result = await storage.read<String>('key');
      expect(result, isNull);
    });
  });

  group('SundayCore Tests', () {
    test('Verify that SundayCore is initialized', () async {
      await SundayCore.init();
      // Verify by performing a simple write and read operation
      final storage = SundayGetStorage();
      await storage.write('core_init_test_key', 'core_init_test_value');
      final result = await storage.read<String>('core_init_test_key');
      expect(result, 'core_init_test_value');
    });
  });

  group('Print Tests', () {
    test('PrintTunnel should print in debug mode', () {
      // Capture print output
      final log = <String>[];
      final spec = ZoneSpecification(print: (_, __, ___, String msg) {
        log.add(msg);
      });

      // Run the printTunnel function in a zone that captures print output
      Zone.current.fork(specification: spec).run(() {
        SundayPrint('test message');
      });

      expect(log, ['test message']);
    });
  });
}
