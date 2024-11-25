import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';

class FitButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String label;
  final VoidCallback onClick;

  const FitButton({
    super.key,
    required this.buttonColor,
    this.textColor = Colors.white,
    required this.label,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: buttonColor,
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
                color: textColor,
                fontSize: 14,
                fontWeight: fitWeightBold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
