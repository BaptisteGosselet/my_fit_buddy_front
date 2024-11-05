import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

class FitSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const FitSearchBar({super.key, required this.controller});

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
              border: Border.all(color: fitBlueDark, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller, 
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'LABEL ENTREZ DU TEXTE ICI',
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                suffixIcon: Icon(
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
