import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:my_fit_buddy/views/widgets/previous_records_widget/previous_records_row.dart';

class PreviousRecordsList extends StatelessWidget {
  const PreviousRecordsList({super.key});

  @override
  Widget build(BuildContext context) {
    const double thisFontSize = 14;
    const FontWeight thisFontWeight = fitWeightBold;
    const Color thisTextColor = Colors.black54;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0, 
        vertical: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'TDate',
                  style: TextStyle(
                    fontSize: thisFontSize,
                    fontWeight: thisFontWeight,
                    color: thisTextColor,
                  ),
                ),
                Spacer(),
                Text(
                  'TReps',
                  style: TextStyle(
                    fontSize: thisFontSize,
                    fontWeight: thisFontWeight,
                    color: thisTextColor,
                  ),
                ),
                Spacer(),
                Text(
                  'TKG',
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
          const SizedBox(height: 8.0),
          
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 120, 
            ),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(7, (index) {
                  return const Column(
                    children: [
                      RecordRow(),
                      SizedBox(height: 8.0),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
