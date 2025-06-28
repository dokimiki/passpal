import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/features/login/application/login_form_notifier.dart';
import 'package:passpal/features/login/application/validators.dart';
import 'package:passpal/features/login/presentation/widgets/primary_button.dart';
import 'package:passpal/features/login/presentation/widgets/error_banner.dart';

/// First step of login flow - Student ID input
class StudentIdPage extends ConsumerStatefulWidget {
  const StudentIdPage({super.key});

  @override
  ConsumerState<StudentIdPage> createState() => _StudentIdPageState();
}

class _StudentIdPageState extends ConsumerState<StudentIdPage> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _validationError;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged(String value) {
    final error = LoginValidators.validateStudentId(value);
    if (error != _validationError) {
      setState(() {
        _validationError = error;
      });
    }
  }

  void _onSubmit() {
    if (_validationError == null && _controller.text.isNotEmpty) {
      ref
          .read(loginFormNotifierProvider.notifier)
          .setStudentId(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginFormNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Student ID'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // Title and description
              Text(
                'Enter your Student ID',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Text(
                'Please enter your student ID in the format: A123456',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Student ID input field
              TextField(
                controller: _controller,
                onChanged: _onTextChanged,
                onSubmitted: (_) => _onSubmit(),
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: 'Student ID',
                  hintText: 'e.g., A123456',
                  errorText: _validationError,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                ),
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

              // Next button
              loginState.when(
                data: (state) => PrimaryButton(
                  onPressed: _onSubmit,
                  text: 'Next',
                  isLoading: state.isLoading,
                  isEnabled:
                      _validationError == null && _controller.text.isNotEmpty,
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
                  isEnabled:
                      _validationError == null && _controller.text.isNotEmpty,
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
