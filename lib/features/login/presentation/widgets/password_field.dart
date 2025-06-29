import 'package:flutter/material.dart';

/// Password input field with visibility toggle
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.labelText = 'Password',
    this.errorText,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String labelText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: widget.controller,
      obscureText: _isObscured,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.password_outlined),
        filled: true,
        fillColor: theme.colorScheme.surface,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
          icon: Icon(
            _isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
    );
  }
}