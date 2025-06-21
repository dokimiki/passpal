import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';
import 'core/background/ios_scheduler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize platform-specific background services
  await _initializeBackgroundServices();

  runApp(ProviderScope(child: PasspalApp()));
}

/// Initializes background services based on the current platform.
Future<void> _initializeBackgroundServices() async {
  if (Platform.isAndroid) {
    // Initialize WorkManager for Android
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false, // Set to true for debugging
    );
  } else if (Platform.isIOS) {
    // Initialize Background Fetch for iOS
    await IosScheduler.initialize();
  }
}

/// Callback dispatcher for Android WorkManager tasks.
///
/// This function is called when a background task is executed on Android.
/// It runs in a separate isolate, so it needs to be a top-level function.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // TODO: Implement task execution logic based on task name
    // This would typically dispatch to the appropriate task handler

    switch (task) {
      case 'assignmentCheck':
        // Handle assignment difference check
        break;
      case 'reminderNotification':
        // Handle reminder notifications
        break;
      default:
        // Unknown task
        break;
    }

    return Future.value(true);
  });
}

class PasspalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ぱすぱる',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: Text('ぱすぱる')),
        body: Center(child: Text('Hello, ぱすぱる!')),
      ),
    );
  }
}
