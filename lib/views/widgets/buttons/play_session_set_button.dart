import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaySessionSetButton extends StatefulWidget {
  final int setNumber;
  final VoidCallback onPressed;
  final bool isCurrentSet;

  const PlaySessionSetButton({
    super.key,
    required this.isCurrentSet,
    required this.setNumber,
    required this.onPressed,
  });

  @override
  State<PlaySessionSetButton> createState() => PlaySessionSetButtonState();
}

class PlaySessionSetButtonState extends State<PlaySessionSetButton> {
  @override
  Widget build(BuildContext context) {
    const backgroundColor = fitBlueMiddle;
    const textColor = Colors.white;

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
          border: widget.isCurrentSet
              ? Border.all(color: Colors.white, width: 1.0)
              : null,
        ),
        child: Text(
          "${AppLocalizations.of(context)!.set} ${widget.setNumber}",
          style: const TextStyle(
            color: textColor,
            fontSize: 10,
            fontWeight: fitWeightBold,
          ),
        ),
      ),
    );
  }
}
