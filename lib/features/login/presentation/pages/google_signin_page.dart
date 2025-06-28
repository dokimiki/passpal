import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/features/login/application/login_form_notifier.dart';
import 'package:passpal/features/login/presentation/widgets/primary_button.dart';
import 'package:passpal/features/login/presentation/widgets/error_banner.dart';

/// Second step of login flow - Google Sign-in
class GoogleSigninPage extends ConsumerWidget {
  const GoogleSigninPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginFormNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Google Sign-in'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),

            // Google logo placeholder
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(Icons.g_mobiledata, size: 48),
            ),
            const SizedBox(height: 32),

            // Title and description
            Text(
              'Sign in with Google',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            loginState.when(
              data: (state) {
                final expectedEmail = state.studentId?.expectedEmail ?? '';

                return Text(
                  'Please sign in with your Chukyo University Google account:\\n$expectedEmail',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text(
                'Error loading student information',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),

            // Error banner from state
            loginState.when(
              data: (state) {
                if (state.errorMessage != null) {
                  return Column(
                    children: [
                      ErrorBanner(
                        message: state.errorMessage!,
                        onDismiss: () {
                          ref
                              .read(loginFormNotifierProvider.notifier)
                              .clearError();
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
              loading: () => const SizedBox.shrink(),
              error: (error, _) => Column(
                children: [
                  ErrorBanner(message: error.toString()),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Sign in button
            loginState.when(
              data: (state) => PrimaryButton(
                onPressed: () {
                  ref
                      .read(loginFormNotifierProvider.notifier)
                      .handleGoogleSignin();
                },
                text: 'Sign in with Google',
                isLoading: state.isLoading,
              ),
              loading: () => const PrimaryButton(
                onPressed: null,
                text: 'Sign in with Google',
                isLoading: true,
                isEnabled: false,
              ),
              error: (_, __) => PrimaryButton(
                onPressed: () {
                  ref
                      .read(loginFormNotifierProvider.notifier)
                      .handleGoogleSignin();
                },
                text: 'Sign in with Google',
              ),
            ),

            const SizedBox(height: 16),

            // Back button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Back'),
            ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
