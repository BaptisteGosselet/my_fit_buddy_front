import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:my_fit_buddy/views/widgets/buttons/fit_button.dart';
import 'package:my_fit_buddy/views/widgets/inputs/fit_text_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FitTimePicker extends StatefulWidget {
  const FitTimePicker({
    super.key,
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  State<FitTimePicker> createState() => _FitTimePickerState();
}

class _FitTimePickerState extends State<FitTimePicker> {
  final double fontSize = 25.0;

  Future<void> _selectDuration(BuildContext context) async {
    int selectedMinutes = 0;
    int selectedSeconds = 0;

    final itemStyle = TextStyle(
        fontSize: fontSize, fontWeight: fitWeightMedium, color: fitBlueDark);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            AppLocalizations.of(context)!.timePickerTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Sélection des minutes
                    Column(
                      children: [
                        Text(AppLocalizations.of(context)!.minutes),
                        SizedBox(
                          height: 100,
                          width: 60,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 30,
                            useMagnifier: true,
                            magnification: 1.5,
                            physics: const FixedExtentScrollPhysics(),
                            onSelectedItemChanged: (value) {
                              selectedMinutes = value;
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) => Text(
                                  index.toString().padLeft(2, '0'),
                                  style: itemStyle),
                              childCount: 60, // Limite à 60 minutes
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Sélection des secondes (par intervalles de 10 secondes)
                    Column(
                      children: [
                        Text(AppLocalizations.of(context)!.seconds),
                        SizedBox(
                          height: 100,
                          width: 60,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 30,
                            useMagnifier: true,
                            magnification: 1.5,
                            physics: const FixedExtentScrollPhysics(),
                            onSelectedItemChanged: (value) {
                              selectedSeconds = value * 10;
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) => Text(
                                (index * 10).toString().padLeft(2, '0'),
                                style: itemStyle,
                              ),
                              childCount:
                                  6, // 6 options (0, 10, 20, 30, 40, 50)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            FitButton(
                buttonColor: fitBlueDark,
                label: AppLocalizations.of(context)!.buttonOk,
                onClick: () {
                  final formattedDuration =
                      "${selectedMinutes.toString().padLeft(2, '0')}:${selectedSeconds.toString().padLeft(2, '0')}";
                  widget.controller.text = formattedDuration;
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDuration(context),
      child: AbsorbPointer(
        child: FitTextInput(
          label: widget.label,
          controller: widget.controller,
          hintText: "00:00",
        ),
      ),
    );
  }
}
