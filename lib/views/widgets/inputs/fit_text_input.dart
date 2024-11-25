import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

class FitTextInput extends StatelessWidget {
  const FitTextInput({
    super.key,
    required this.label,
    this.isHidden = false,
    required this.controller,
    this.inputFormatters,
    this.hintText,
    this.keyboardType,
    this.borderRadiusValue = 20.0,
  });

  final String label;
  final bool isHidden;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final TextInputType? keyboardType;
  final double borderRadiusValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: isHidden,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadiusValue),
                borderSide: const BorderSide(width: 2, color: fitBlueDark),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadiusValue),
                borderSide: const BorderSide(width: 2, color: fitBlueDark),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
