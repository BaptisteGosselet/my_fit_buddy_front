import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/fit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            AppLocalizations.of(context)!.createExerciseDialogTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: const Text("Are you sure to supp ?"),
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
