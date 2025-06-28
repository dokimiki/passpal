import 'package:flutter/material.dart';
import 'package:passpal/core/theme/extensions/passpal_theme_ext.dart';

/// Illustration widget for maintenance page
class MaintenanceIllustration extends StatelessWidget {
  const MaintenanceIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<PasspalThemeExt>()!;

    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: theme.maintenanceBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(Icons.build_rounded, size: 80, color: Colors.orange),
    );
  }
}
