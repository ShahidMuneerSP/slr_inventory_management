// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast(BuildContext context, String title, String description,
    ToastificationType type) {
  toastification.show(
    alignment: Alignment.bottomRight,
    context: context,
    type: type,
    icon: type == ToastificationType.success
        ? const Icon(Icons.check_circle_outline)
        : type == ToastificationType.warning
            ? const Icon(Icons.warning_amber_rounded)
            : const Icon(Icons.error_outline_sharp),
    title: Text(title),
    description: Text(description),
    primaryColor: Colors.white,
    autoCloseDuration: const Duration(seconds: 3),
    progressBarTheme: ProgressIndicatorThemeData(
      color: type == ToastificationType.success
          ? Colors.green
          : type == ToastificationType.warning
              ? Colors.orange
              : Colors.red,
    ),
    showProgressBar: true,
    backgroundColor: type == ToastificationType.success
        ? Colors.green
        : type == ToastificationType.warning
            ? Colors.orange
            : Colors.red,
    foregroundColor: Colors.white,
  );
}
