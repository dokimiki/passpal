import 'package:flutter/material.dart';
import 'package:passpal/core/theme/extensions/passpal_theme_ext.dart';

/// Common scaffold for system pages (maintenance, force-update, error)
class SystemScaffold extends StatelessWidget {
  const SystemScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<PasspalThemeExt>()!;

    return Scaffold(
      backgroundColor: theme.surface1,
      appBar: AppBar(title: Text(title), backgroundColor: theme.surface1),
      body: SafeArea(child: body),
      persistentFooterButtons: actions,
    );
  }
}
