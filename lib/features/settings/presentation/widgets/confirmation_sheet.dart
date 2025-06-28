import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmationSheet extends StatelessWidget {
  const ConfirmationSheet({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.onConfirm,
    this.cancelText = 'キャンセル',
    this.isDestructive = false,
  });

  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(title),
      message: Text(message),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          isDestructiveAction: isDestructive,
          child: Text(confirmText),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(cancelText),
      ),
    );
  }
}

/// ConfirmationSheetの表示ヘルパー
Future<void> showConfirmationSheet(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmText,
  required VoidCallback onConfirm,
  String cancelText = 'キャンセル',
  bool isDestructive = false,
}) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => ConfirmationSheet(
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      isDestructive: isDestructive,
    ),
  );
}
