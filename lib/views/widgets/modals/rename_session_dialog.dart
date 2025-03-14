import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:my_fit_buddy/views/widgets/buttons/fit_button.dart';
import '../inputs/fit_text_input.dart';

class RenameSessionDialog extends StatefulWidget {
  final Function(int id, String newName) onRename;
  final int id;
  final String title;

  const RenameSessionDialog({
    super.key,
    required this.id,
    required this.title,
    required this.onRename,
  });

  @override
  State<RenameSessionDialog> createState() => _RenameSessionState();
}

class _RenameSessionState extends State<RenameSessionDialog> {
  final TextEditingController renameSessionController = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    renameSessionController.dispose();
    super.dispose();
  }

  bool _validateInput(String value) {
    if (value.isEmpty || value.length > 25) {
      setState(() {
        errorMessage = AppLocalizations.of(context)!.renameSessionErrorMsg;
      });
      return false;
    }
    setState(() {
      errorMessage = null;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.renameSessionTitle,
              style: const TextStyle(fontWeight: fitWeightBold, fontSize: 18),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FitTextInput(
            label: AppLocalizations.of(context)!.renameSessionLabel,
            controller: renameSessionController,
          ),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.redAccent, fontSize: 12),
              ),
            ),
        ],
      ),
      actions: [
        FitButton(
          buttonColor: fitBlueDark,
          label: AppLocalizations.of(context)!.renameButton,
          onClick: () {
            if (_validateInput(renameSessionController.text)) {
              Navigator.of(context).pop();
              widget.onRename(widget.id, renameSessionController.text);
            }
          },
        ),
      ],
    );
  }
}
