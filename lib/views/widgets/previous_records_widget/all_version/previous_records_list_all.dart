import 'package:flutter/material.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_fit_buddy/views/widgets/previous_records_widget/all_version/previous_records_row_with_order.dart';

class PreviousRecordsListAll extends StatelessWidget {
  final List<FitSet> previousSets;

  const PreviousRecordsListAll({
    super.key,
    required this.previousSets,
  });

  @override
  Widget build(BuildContext context) {
    const double thisFontSize = 14;
    const FontWeight thisFontWeight = fitWeightBold;
    const Color thisTextColor = Colors.black54;

    if (previousSets.isEmpty) {
      return const Center(
        child: Text(
          "LABEL NO PREVIOUS SETS",
          style: TextStyle(
            fontSize: thisFontSize,
            fontWeight: thisFontWeight,
            color: thisTextColor,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                  AppLocalizations.of(context)!.set,
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
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: previousSets.map((fitSet) {
                  return Column(
                    children: [
                      RecordRowWithOrder(fitSet: fitSet),
                      const SizedBox(height: 8.0),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
