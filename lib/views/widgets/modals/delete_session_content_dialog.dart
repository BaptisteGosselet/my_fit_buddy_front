import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:my_fit_buddy/views/widgets/buttons/fit_button.dart';

class DeleteSessionContentDialog extends StatefulWidget {
  final Function(int id) onConfirm;
  final int id;

  const DeleteSessionContentDialog({
    super.key,
    required this.id,
    required this.onConfirm,
  });

  @override
  State<DeleteSessionContentDialog> createState() =>
      _DeleteSessionContentState();
}

class _DeleteSessionContentState extends State<DeleteSessionContentDialog> {
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
            AppLocalizations.of(context)!.deleteContentConfirmTitle,
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
      content: Text(
        AppLocalizations.of(context)!.deleteContentConfirmMsg,
      ),
      actions: [
        FitButton(
          buttonColor: fitBlueDark,
          label: AppLocalizations.of(context)!.deleteButton,
          onClick: () {
            Navigator.of(context).pop();
            widget.onConfirm(widget.id);
          },
        ),
      ],
    );
  }
}
