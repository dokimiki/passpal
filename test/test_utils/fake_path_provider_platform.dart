import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

/// Fake implementation of PathProviderPlatform for testing.
class FakePathProviderPlatform extends PathProviderPlatform {
  static String? _tempDirectory;

  @override
  Future<String?> getApplicationDocumentsPath() async {
    _tempDirectory ??= Directory.systemTemp
        .createTempSync('passpal_test_')
        .path;
    return _tempDirectory;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return getApplicationDocumentsPath();
  }

  @override
  Future<String?> getTemporaryPath() async {
    return getApplicationDocumentsPath();
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return getApplicationDocumentsPath();
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    final tempDir = await getApplicationDocumentsPath();
    return tempDir != null ? [tempDir] : null;
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    final tempDir = await getApplicationDocumentsPath();
    return tempDir != null ? [tempDir] : null;
  }

  @override
  Future<String?> getLibraryPath() async {
    return getApplicationDocumentsPath();
  }

  /// Cleans up the temporary directory created for testing.
  static void cleanup() {
    if (_tempDirectory != null) {
      try {
        final dir = Directory(_tempDirectory!);
        if (dir.existsSync()) {
          dir.deleteSync(recursive: true);
        }
      } catch (e) {
        // Ignore cleanup errors
      }
      _tempDirectory = null;
    }
  }
}
