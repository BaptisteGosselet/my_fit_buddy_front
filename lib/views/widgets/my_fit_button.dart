import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

enum ButtonColor { primary, secondary }

class MyFitButton extends StatelessWidget {
  final ButtonColor buttonColor;
  final String label;
  final VoidCallback onClick;

  const MyFitButton({
    super.key,
    required this.buttonColor,
    required this.label,
    required this.onClick,
  });

  Color _getBackgroundColor() {
    switch (buttonColor) {
      case ButtonColor.primary:
        return Colors.black;
      case ButtonColor.secondary:
        return fitBlueDark;
    }
  }

  Color _getTextColor() {
    switch (buttonColor) {
      case ButtonColor.primary:
        return Colors.white;
      case ButtonColor.secondary:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: _getBackgroundColor(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            shadowColor: Colors.grey.withOpacity(0.5),
          ),
          onPressed: onClick,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              label,
              style: TextStyle(
                color: _getTextColor(),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
