import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_fit_buddy/utils/utils.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/fit_button.dart';
import 'package:my_fit_buddy/views/widgets/inputs/fit_text_input.dart';
import 'package:my_fit_buddy/views/widgets/inputs/fit_time_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomizeExerciseDialog extends StatefulWidget {
  final Function(int reps, int restSeconds) onConfirm;

  const CustomizeExerciseDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  State<CustomizeExerciseDialog> createState() =>
      _CustomizeExerciseDialogState();
}

class _CustomizeExerciseDialogState extends State<CustomizeExerciseDialog> {
  final TextEditingController repsController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  @override
  void dispose() {
    repsController.dispose();
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double inputWidth = 100;
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: inputWidth,
                child: FitTextInput(
                  label: AppLocalizations.of(context)!.repetitionsInputLabel,
                  controller: repsController,
                  hintText: "0",
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 15),
              SizedBox(
                width: inputWidth,
                child: FitTimePicker(
                  label: AppLocalizations.of(context)!.restInputLabel,
                  controller: durationController,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        FitButton(
          buttonColor: fitBlueDark,
          label: AppLocalizations.of(context)!.addButton,
          onClick: () {
            Navigator.of(context).pop();
            widget.onConfirm(
              int.tryParse(repsController.text) ?? 0,
              Utils.instance
                  .convertStringTimeToSeconds(durationController.text),
            );
          },
        ),
      ],
    );
  }
}
