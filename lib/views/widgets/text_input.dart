import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {super.key,
      required this.label,
      this.isHidden = false,
      required this.controller});

  final String label;
  final bool isHidden;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Label
          Text(
            label,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 14),
          ),
          // Field
          Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ]),
              child: TextField(
                controller: controller,
                obscureText: isHidden,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(width: 2, color: fitBlueDark),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(width: 2, color: fitBlueDark),
                  ),
                ),
              )),
        ]));
  }
}
