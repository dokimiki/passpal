import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passpal/core/storage/storage_providers.dart';
import 'package:passpal/core/routing/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(sharedPrefs)],
      child: const PassPalApp(),
    ),
  );
}

class PassPalApp extends ConsumerWidget {
  const PassPalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'PassPal',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
