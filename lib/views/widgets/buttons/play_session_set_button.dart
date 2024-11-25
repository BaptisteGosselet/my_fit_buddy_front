import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaySessionSetButton extends StatefulWidget {
  const PlaySessionSetButton({super.key});

  @override
  State<PlaySessionSetButton> createState() => _PlaySessionSetButtonState();
}

class _PlaySessionSetButtonState extends State<PlaySessionSetButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('set');
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: fitBlueMiddle,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          "${AppLocalizations.of(context)!.set} X",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: fitWeightBold,
          ),
        ),
      ),
    );
  }
}
