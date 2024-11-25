import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:my_fit_buddy/views/widgets/previous_records_widget/previous_records_row.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.date,
                  style: const TextStyle(
                    fontSize: thisFontSize,
                    fontWeight: thisFontWeight,
                    color: thisTextColor,
                  ),
                ),
                const Spacer(),
                Text(
                  AppLocalizations.of(context)!.reps,
                  style: const TextStyle(
                    fontSize: thisFontSize,
                    fontWeight: thisFontWeight,
                    color: thisTextColor,
                  ),
                ),
                const Spacer(),
                Text(
                  AppLocalizations.of(context)!.kg,
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
