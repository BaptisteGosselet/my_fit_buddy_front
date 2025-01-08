import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_fit_buddy/managers/toast_manager.dart';
import 'package:my_fit_buddy/utils/utils.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/buttons/fit_button.dart';
import 'package:my_fit_buddy/views/widgets/inputs/fit_text_input.dart';
import 'package:my_fit_buddy/views/widgets/inputs/fit_time_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomizeExerciseDialog extends StatefulWidget {
  final int id;
  final Function(int id, int nbSets, int restSeconds) onConfirm;

  const CustomizeExerciseDialog({
    super.key,
    required this.onConfirm,
    this.id = -1,
  });

  @override
  State<CustomizeExerciseDialog> createState() =>
      _CustomizeExerciseDialogState();
}

class _CustomizeExerciseDialogState extends State<CustomizeExerciseDialog> {
  final TextEditingController nbSetsController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  @override
  void dispose() {
    nbSetsController.dispose();
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
                  label: AppLocalizations.of(context)!.set,
                  controller: nbSetsController,
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
          label: widget.id == -1
              ? AppLocalizations.of(context)!.addButton
              : AppLocalizations.of(context)!.updateButton,
          onClick: () {
            if (validInputs()) {
              Navigator.of(context).pop();
              widget.onConfirm(
                widget.id,
                int.tryParse(nbSetsController.text) ?? 1,
                Utils.instance
                    .convertStringTimeToSeconds(durationController.text),
              );
              ToastManager.instance.showSuccessToast(
                  context,
                  widget.id == -1
                      ? AppLocalizations.of(context)!.toastAddedExercise
                      : AppLocalizations.of(context)!.toastUpdatedExercise);
            } else {
              ToastManager.instance.showErrorToast(context,
                  AppLocalizations.of(context)!.toastInvalidExerciseInputs);
            }
          },
        ),
      ],
    );
  }

  bool validInputs() {
    var value = int.tryParse(nbSetsController.text);
    if (value != null) {
      return (int.parse(nbSetsController.text) > 0);
    }
    return false;
  }
}
