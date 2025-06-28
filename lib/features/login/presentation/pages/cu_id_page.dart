import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/features/login/application/login_form_notifier.dart';
import 'package:passpal/features/login/application/validators.dart';
import 'package:passpal/features/login/presentation/widgets/primary_button.dart';
import 'package:passpal/features/login/presentation/widgets/password_field.dart';
import 'package:passpal/features/login/presentation/widgets/error_banner.dart';

/// Third step of login flow - CU-ID password input and final login
class CuIdPage extends ConsumerStatefulWidget {
  const CuIdPage({super.key});

  @override
  ConsumerState<CuIdPage> createState() => _CuIdPageState();
}

class _CuIdPageState extends ConsumerState<CuIdPage> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _validationError;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged(String value) {
    final error = LoginValidators.validatePassword(value);
    if (error != _validationError) {
      setState(() {
        _validationError = error;
      });
    }
  }

  void _onSubmit() {
    if (_validationError == null && _passwordController.text.isNotEmpty) {
      ref
          .read(loginFormNotifierProvider.notifier)
          .loginWithCuId(_passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginFormNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('CU-ID Login'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // Lock icon
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(Icons.lock_outline, size: 48),
              ),
              const SizedBox(height: 32),

              // Title and description
              Text(
                'Enter your CU-ID Password',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              loginState.when(
                data: (state) {
                  final studentId = state.studentId?.value ?? '';

                  return Text(
                    'Please enter the password for your CU-ID: $studentId',
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

              // Password input field
              PasswordField(
                controller: _passwordController,
                labelText: 'CU-ID Password',
                errorText: _validationError,
                onChanged: _onPasswordChanged,
                onSubmitted: (_) => _onSubmit(),
              ),
              const SizedBox(height: 24),

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

              // Login button
              loginState.when(
                data: (state) => PrimaryButton(
                  onPressed: _onSubmit,
                  text: 'Login',
                  isLoading: state.isLoading,
                  isEnabled:
                      _validationError == null &&
                      _passwordController.text.isNotEmpty,
                ),
                loading: () => const PrimaryButton(
                  onPressed: null,
                  text: 'Login',
                  isLoading: true,
                  isEnabled: false,
                ),
                error: (_, __) => PrimaryButton(
                  onPressed: _onSubmit,
                  text: 'Login',
                  isEnabled:
                      _validationError == null &&
                      _passwordController.text.isNotEmpty,
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
      ),
    );
  }
}
