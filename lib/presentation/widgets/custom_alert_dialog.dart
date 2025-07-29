import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.cancelText = "Cancel",
    this.confirmText = "Yes",
    this.onCancel,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(confirmText),
        ),
      ],
    );
  }
}