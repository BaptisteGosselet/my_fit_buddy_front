import 'package:flutter/material.dart';

class ToastManager {
  ToastManager._singleton();
  static final ToastManager instance = ToastManager._singleton();

  void showCustomToast(
      BuildContext context, String message, Icon icon, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          icon,
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorToast(BuildContext context, String message) {
    showCustomToast(context, message,
        const Icon(Icons.error, color: Colors.white), Colors.red);
  }

  void showSuccessToast(BuildContext context, String message) {
    showCustomToast(context, message,
        const Icon(Icons.check_circle, color: Colors.white), Colors.green);
  }

  void showWarningToast(BuildContext context, String message) {
    showCustomToast(context, message,
        const Icon(Icons.warning, color: Colors.white), Colors.orange);
  }
}
