import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/login/application/login_form_notifier.dart';
import 'package:passpal/features/login/application/validators.dart';
import 'package:passpal/features/login/presentation/widgets/error_banner.dart';
import 'package:passpal/features/login/presentation/widgets/password_field.dart';
import 'package:passpal/features/login/presentation/widgets/primary_button.dart';

/// Third step of login flow - CU-ID password input and final login
class CuIdPage extends ConsumerStatefulWidget {
  const CuIdPage({super.key});

  @override
  ConsumerState<CuIdPage> createState() => _CuIdPageState();
}

class _CuIdPageState extends ConsumerState<CuIdPage> {
  final _passwordController = TextEditingController();
  String? _validationError;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validateInput);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validateInput);
    _passwordController.dispose();
    super.dispose();
  }

  void _validateInput() {
    final text = _passwordController.text;
    final error = LoginValidators.validatePassword(text);
    final newIsEnabled = error == null && text.isNotEmpty;
    if (error != _validationError || newIsEnabled != _isButtonEnabled) {
      setState(() {
        _validationError = error;
        _isButtonEnabled = newIsEnabled;
      });
    }
  }

  void _onSubmit() {
    if (_isButtonEnabled) {
      ref
          .read(loginFormNotifierProvider.notifier)
          .loginWithCuId(_passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loginState = ref.watch(loginFormNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login Step 3/3')),
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
                          Icons.lock_person_outlined,
                          size: 60,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: SpaceTokens.md),
                        Text(
                          'Enter CU-ID Password',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: SpaceTokens.md),
                        loginState.when(
                          data: (state) {
                            final studentId = state.studentId?.value ?? '';
                            return Text(
                              'Enter the password for your university account ($studentId).',
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
                        PasswordField(
                          controller: _passwordController,
                          labelText: 'Password',
                          errorText: _validationError,
                          onSubmitted: (_) => _onSubmit(),
                        ),
                        const SizedBox(height: SpaceTokens.lg),
                        loginState.when(
                          data: (state) => PrimaryButton(
                            onPressed: _onSubmit,
                            text: 'Login & Continue',
                            isLoading: state.isLoading,
                            isEnabled: _isButtonEnabled,
                          ),
                          loading: () => const PrimaryButton(
                            onPressed: null,
                            text: 'Login & Continue',
                            isLoading: true,
                          ),
                          error: (e, s) => PrimaryButton(
                            onPressed: _onSubmit,
                            text: 'Retry Login',
                            isEnabled: _isButtonEnabled,
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
                  child: const Text('Back to Google Sign-in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
