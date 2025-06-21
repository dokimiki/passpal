import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/error/error_handler.dart';

/// Example usage of ErrorHandler and OverlayErrorWidget
///
/// This file demonstrates how to integrate the error handling system
/// into your Flutter application with proper Riverpod setup.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        // Override the errorHandlerProvider with proper NavigatorKey
        errorHandlerProvider.overrideWithValue(ErrorHandler(_navigatorKey)),
      ],
      child: MaterialApp(
        title: 'PassPal Error Handling Demo',
        navigatorKey: _navigatorKey,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const ExampleScreen(),
      ),
    );
  }
}

class ExampleScreen extends ConsumerWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Handling Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tap buttons below to simulate different types of network errors:',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _simulateDioError(ref),
              child: const Text('Simulate DioException (503)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _simulateSocketError(ref),
              child: const Text('Simulate SocketException'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _simulateGenericError(ref),
              child: const Text('Simulate Generic Error (No Overlay)'),
            ),
          ],
        ),
      ),
    );
  }

  void _simulateDioError(WidgetRef ref) {
    // Import dio package to access DioException
    // final dioError = DioException(
    //   requestOptions: RequestOptions(path: '/api/test'),
    //   response: Response(
    //     requestOptions: RequestOptions(path: '/api/test'),
    //     statusCode: 503,
    //   ),
    // );

    // ref.handleNetworkError(
    //   dioError,
    //   onRetry: () {
    //     debugPrint('Retrying DioException request...');
    //     // Implement actual retry logic here
    //   },
    // );
  }

  void _simulateSocketError(WidgetRef ref) {
    // Import dart:io to access SocketException
    // const socketError = SocketException('Network unreachable');

    // ref.handleNetworkError(
    //   socketError,
    //   onRetry: () {
    //     debugPrint('Retrying SocketException request...');
    //     // Implement actual retry logic here
    //   },
    // );
  }

  void _simulateGenericError(WidgetRef ref) {
    final genericError = Exception('This is not a network error');

    final handled = ref.handleNetworkError(
      genericError,
      onRetry: () {
        debugPrint('This should not be called');
      },
    );

    if (!handled) {
      // Show SnackBar for non-network errors
      ScaffoldMessenger.of(ref.context).showSnackBar(
        const SnackBar(
          content: Text('Generic error occurred (handled differently)'),
        ),
      );
    }
  }
}

/// Example of how to use error handling in a data layer
class ExampleRepository {
  const ExampleRepository(this._ref);

  final Ref _ref;

  Future<String> fetchData() async {
    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 1));
      throw Exception('Simulated network error');
    } catch (error) {
      // Try to handle network errors with overlay
      final handled = _ref
          .read(errorHandlerProvider)
          .handleNetworkError(
            error,
            onRetry: fetchData, // Retry the same operation
          );

      if (!handled) {
        // Handle other types of errors
        _ref.read(errorHandlerProvider).handleGeneralError(error);
      }

      rethrow;
    }
  }
}

/// Provider for the example repository
final exampleRepositoryProvider = Provider<ExampleRepository>((ref) {
  return ExampleRepository(ref);
});
