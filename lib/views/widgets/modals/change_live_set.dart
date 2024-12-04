import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLiveSet extends StatelessWidget {
  const ChangeLiveSet({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.changeSetTitle),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(AppLocalizations.of(context)!.changeSetOptionCancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(AppLocalizations.of(context)!.changeSetOptionConfirm),
        ),
      ],
    );
  }
}
