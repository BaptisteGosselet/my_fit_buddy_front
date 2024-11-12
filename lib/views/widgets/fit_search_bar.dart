import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FitSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSearchChanged;

  const FitSearchBar({
    super.key,
    required this.controller,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: 320,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: fitBlueDark, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppLocalizations.of(context)!.exercisesSearch,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                suffixIcon: const Icon(
                  Icons.search,
                  color: fitBlueDark,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
