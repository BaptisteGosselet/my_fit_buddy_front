import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:my_fit_buddy/views/widgets/buttons/fit_button.dart';

class ChooseSessionContentDialog extends StatefulWidget {
  final Function(int id) onConfirm;
  final int id;

  const ChooseSessionContentDialog({
    super.key,
    required this.id,
    required this.onConfirm,
  });

  @override
  State<ChooseSessionContentDialog> createState() =>
      _ChooseSessionContentState();
}

class _ChooseSessionContentState extends State<ChooseSessionContentDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.actionContentModalTitle,
            style: const TextStyle(fontWeight: fitWeightBold, fontSize: 18),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      actions: [
        FitButton(
          buttonColor: fitBlueMiddle,
          label: AppLocalizations.of(context)!.deleteButton,
          onClick: () {
            Navigator.of(context).pop();
            widget.onConfirm(1);
          },
        ),
        FitButton(
          buttonColor: fitBlueDark,
          label: AppLocalizations.of(context)!.updateButton,
          onClick: () {
            Navigator.of(context).pop();
            widget.onConfirm(2);
          },
        ),
      ],
    );
  }
}
