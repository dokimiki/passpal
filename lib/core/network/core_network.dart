/// Core network components for the Passpal application.
///
/// This library provides:
/// - [BaseDioWrapper]: A configured HTTP client with retry logic
/// - [Environment]: Environment configuration for different build flavors
/// - [dioProvider]: Riverpod provider for dependency injection
///
/// Example usage:
/// ```dart
/// final dio = ref.watch(dioProvider);
/// final response = await dio.get('/api/endpoint');
/// ```
library core_network;

export 'base_dio_wrapper.dart';
export 'environment.dart';
export 'network_provider.dart';
