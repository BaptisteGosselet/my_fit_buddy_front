import 'package:flutter/material.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set.dart';
import 'package:my_fit_buddy/utils/utils.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';

class RecordRow extends StatelessWidget {
  final FitSet fitSet;

  const RecordRow({
    super.key,
    required this.fitSet,
  });

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Utils.instance
                  .getRecordsDateString_1(context, fitSet.record.date),
              style: const TextStyle(
                fontSize: thisFontSize,
                fontWeight: thisFontWeight,
                color: thisTextColor,
              ),
            ),
            const Spacer(),
            Text(
              fitSet.nbRep.toString(),
              style: const TextStyle(
                fontSize: thisFontSize,
                fontWeight: thisFontWeight,
                color: thisTextColor,
              ),
            ),
            const Spacer(),
            Text(
              fitSet.weight.toString(),
              style: const TextStyle(
                fontSize: thisFontSize,
                fontWeight: thisFontWeight,
                color: thisTextColor,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
