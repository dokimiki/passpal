import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/config/services/config_cache.dart';
import 'package:passpal/core/error/providers.dart';
import 'package:passpal/core/error/testing/mock_crashlytics.dart';
import 'package:passpal/core/error/testing/mock_logger.dart';

import '../mocks/mock_config_services.dart';

/// Mock provider overrides for integration testing
class MockProviderOverrides {
  static List<Override> get overrides => [
    crashlyticsServiceProvider.overrideWithValue(MockCrashlyticsService()),
    errorReporterProvider.overrideWithValue(MockErrorReporter()),
    configCacheProvider.overrideWithValue(MockConfigCache()),
  ];
}
