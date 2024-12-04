import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuitLiveSession extends StatelessWidget {
  final VoidCallback onConfirm;

  const QuitLiveSession({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.quitSessionModalTitle),
      content: Text(AppLocalizations.of(context)!.quitSessionModalMessage),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child:
              Text(AppLocalizations.of(context)!.quitSessionModalOptionCancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child:
              Text(AppLocalizations.of(context)!.quitSessionModalOptionConfirm),
        ),
      ],
    );
  }
}
