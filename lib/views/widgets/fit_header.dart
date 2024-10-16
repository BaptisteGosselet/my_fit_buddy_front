import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';

class FitHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final VoidCallback? onLeftIconPressed;
  final VoidCallback? onRightIconPressed;

  const FitHeader({
    super.key,
    required this.title,
    this.subtitle = '',
    this.leftIcon,
    this.rightIcon,
    this.onLeftIconPressed,
    this.onRightIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    const double iconSize = 25;
    Color highlightColor = Colors.white.withOpacity(0.1);

    Widget? buildIcon(IconData? icon, VoidCallback? onPressed) {
      return icon == null
          ? null
          : IconButton(
              icon: Icon(icon, color: Colors.white, size: iconSize),
              onPressed: onPressed,
              padding: const EdgeInsets.all(8),
              highlightColor: highlightColor,
            );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 30, bottom: 16, left: 10, right: 10),
      color: fitBlueDark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildIcon(leftIcon, onLeftIconPressed) ?? const SizedBox.shrink(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: fitWeightBold,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          buildIcon(rightIcon, onRightIconPressed) ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
