/// Config Core Module Providers
/// 
/// This file exports all configuration-related providers for easy access
/// from other parts of the application.
/// 
/// Usage:
/// ```dart
/// import 'package:passpal/core/config/providers.dart';
/// 
/// // Use any config provider
/// final config = ref.watch(appConfigProvider);
/// final apiConfig = ref.watch(apiConfigProvider);
/// ```
library;

// Main configuration providers
export 'providers/config_provider.dart';

// Service providers (generated)
export 'services/config_cache.dart' show configCacheProvider;
export 'services/config_merger.dart' show configMergerProvider;
export 'services/config_update_monitor.dart' show configUpdateMonitorProvider;

// Source providers (generated)
export 'sources/env_config_source.dart' show envConfigSourceProvider;
export 'sources/remote_config_source.dart' show remoteConfigSourceProvider;

// Services without providers (direct instantiation)
export 'services/config_validation.dart' show ConfigValidation;