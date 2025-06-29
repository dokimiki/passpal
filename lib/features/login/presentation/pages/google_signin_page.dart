import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/login/application/login_form_notifier.dart';
import 'package:passpal/features/login/presentation/widgets/error_banner.dart';
import 'package:passpal/features/login/presentation/widgets/primary_button.dart';

/// Second step of login flow - Google Sign-in
class GoogleSigninPage extends ConsumerWidget {
  const GoogleSigninPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final loginState = ref.watch(loginFormNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login Step 2/3')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(SpaceTokens.md),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 0,
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.3,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(SpaceTokens.lg),
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 60,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: SpaceTokens.md),
                        Text(
                          'Sign in with Google',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: SpaceTokens.md),
                        loginState.when(
                          data: (state) {
                            final expectedEmail =
                                state.studentId?.expectedEmail ?? '';
                            return Text(
                              'Please use your university account to continue:\n$expectedEmail',
                              style: theme.textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            );
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (e, _) => Text(
                            'Could not retrieve student information. Please go back and try again.',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: SpaceTokens.lg),
                        loginState.when(
                          data: (state) => Column(
                            children: [
                              Icon(
                                Icons.school,
                                size: 24,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(height: SpaceTokens.sm),
                              PrimaryButton(
                                onPressed: () => ref
                                    .read(loginFormNotifierProvider.notifier)
                                    .handleGoogleSignin(),
                                text: 'サインイン（学内Googleアカウント）',
                                isLoading: state.isLoading,
                              ),
                            ],
                          ),
                          loading: () => const PrimaryButton(
                            onPressed: null,
                            text: 'サインイン（学内Googleアカウント）',
                            isLoading: true,
                          ),
                          error: (e, s) => PrimaryButton(
                            onPressed: () => ref
                                .read(loginFormNotifierProvider.notifier)
                                .handleGoogleSignin(),
                            text: 'Retry Google Sign-in',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: SpaceTokens.md),
                loginState.when(
                  data: (state) {
                    if (state.errorMessage != null) {
                      return ErrorBanner(
                        message: state.errorMessage!,
                        onDismiss: () => ref
                            .read(loginFormNotifierProvider.notifier)
                            .clearError(),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (error, _) => ErrorBanner(message: error.toString()),
                ),
                const SizedBox(height: SpaceTokens.sm),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Back to Student ID'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
