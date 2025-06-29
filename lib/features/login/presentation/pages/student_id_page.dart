import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/login/application/login_form_notifier.dart';
import 'package:passpal/features/login/application/validators.dart';
import 'package:passpal/features/login/presentation/widgets/error_banner.dart';
import 'package:passpal/features/login/presentation/widgets/primary_button.dart';

/// First step of login flow - Student ID input
class StudentIdPage extends ConsumerStatefulWidget {
  const StudentIdPage({super.key});

  @override
  ConsumerState<StudentIdPage> createState() => _StudentIdPageState();
}

class _StudentIdPageState extends ConsumerState<StudentIdPage> {
  final _controller = TextEditingController();
  String? _validationError;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_validateInput);
  }

  @override
  void dispose() {
    _controller.removeListener(_validateInput);
    _controller.dispose();
    super.dispose();
  }

  void _validateInput() {
    final text = _controller.text;
    final error = LoginValidators.validateStudentId(text);
    final newIsEnabled = error == null && text.isNotEmpty;
    if (error != _validationError || newIsEnabled != _isButtonEnabled) {
      setState(() {
        _validationError = error;
        _isButtonEnabled = newIsEnabled;
      });
    }
  }

  void _onSubmit() async {
    if (_isButtonEnabled) {
      await ref
          .read(loginFormNotifierProvider.notifier)
          .setStudentId(_controller.text);
      // Navigation is handled within setStudentId method
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loginState = ref.watch(loginFormNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login Step 1/3')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(SpaceTokens.md),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome to PassPal',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: SpaceTokens.sm),
                Text(
                  'Your new campus life assistant',
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: SpaceTokens.xl),
                Card(
                  elevation: 0,
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.3,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(SpaceTokens.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Enter your Student ID',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: SpaceTokens.sm),
                        Text(
                          'Format: A123456',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: SpaceTokens.lg),
                        TextField(
                          controller: _controller,
                          onSubmitted: (_) => _onSubmit(),
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            labelText: 'Student ID',
                            hintText: 'e.g., A123456',
                            errorText: _validationError,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.person_outline),
                            filled: true,
                            fillColor: theme.colorScheme.surface,
                          ),
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                        const SizedBox(height: SpaceTokens.lg),
                        loginState.when(
                          data: (state) => PrimaryButton(
                            onPressed: _onSubmit,
                            text: 'Next',
                            isLoading: state.isLoading,
                            isEnabled: _isButtonEnabled,
                          ),
                          loading: () => const PrimaryButton(
                            onPressed: null,
                            text: 'Next',
                            isLoading: true,
                            isEnabled: false,
                          ),
                          error: (_, __) => PrimaryButton(
                            onPressed: _onSubmit,
                            text: 'Next',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
