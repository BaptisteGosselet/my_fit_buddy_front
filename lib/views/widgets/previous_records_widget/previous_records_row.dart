import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';

class RecordRow extends StatelessWidget {
  const RecordRow({super.key});

  @override
  Widget build(BuildContext context) {
    const double thisFontSize = 14;
    const FontWeight thisFontWeight = fitWeightMedium;
    const Color thisTextColor = Colors.black;
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'XX/YY',
              style: TextStyle(
                fontSize: thisFontSize,
                fontWeight: thisFontWeight,
                color: thisTextColor,
              ),
            ),
            Spacer(),
            Text(
              'XX',
              style: TextStyle(
                fontSize: thisFontSize,
                fontWeight: thisFontWeight,
                color: thisTextColor,
              ),
            ),
            Spacer(),
            Text(
              'YY',
              style: TextStyle(
                fontSize: thisFontSize,
                fontWeight: thisFontWeight,
                color: thisTextColor,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
