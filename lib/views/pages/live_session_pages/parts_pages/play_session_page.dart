import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set.dart';
import 'package:my_fit_buddy/data/models/session_content_models/session_content_exercise.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/headers/play_session_header.dart';
import 'package:my_fit_buddy/views/widgets/inputs/fit_text_input.dart';
import 'package:my_fit_buddy/views/widgets/previous_records_widget/live_version/previous_records_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaySessionPage extends StatelessWidget {
  final SessionContentExercise sessionContentExercise;
  final List<FitSet> previousExerciseSets;
  final FitSet? previousEntry;
  final Function(SessionContentExercise, int, int) onFinishClick;
  final Function(int setNumber) onSetPressed;
  final int currentSetNumber;
  final int currentRecordId;

  const PlaySessionPage(
      {super.key,
      required this.sessionContentExercise,
      required this.previousExerciseSets,
      required this.previousEntry,
      required this.onFinishClick,
      required this.onSetPressed,
      required this.currentSetNumber,
      required this.currentRecordId});

  FitSet? getExerciseLastSet() {
    if (previousExerciseSets.isEmpty) {
      if (previousEntry != null) {
        return previousEntry;
      }
      return null;
    }
    return previousExerciseSets.first;
  }

  String lastReps() {
    FitSet? lastSet = getExerciseLastSet();
    if (lastSet == null) {
      return "";
    }
    return lastSet.nbRep.toString();
  }

  String lastWeight() {
    FitSet? lastSet = getExerciseLastSet();
    if (lastSet == null) {
      return "";
    }
    return lastSet.weight.toString();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController repsTextController =
        TextEditingController(text: lastReps());
    TextEditingController weightTextController =
        TextEditingController(text: lastWeight());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PlaySessionHeader(
              sessionContentExercise: sessionContentExercise,
              onSetPressed: onSetPressed,
              currentSetNumber: currentSetNumber,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: FitTextInput(
                      label: AppLocalizations.of(context)!.reps,
                      controller: repsTextController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      borderRadiusValue: 10,
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 150,
                    child: FitTextInput(
                      label: AppLocalizations.of(context)!.kg,
                      controller: weightTextController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      borderRadiusValue: 10,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final reps = int.tryParse(repsTextController.text);
                    final weight = int.tryParse(weightTextController.text);

                    if (reps != null && weight != null) {
                      onFinishClick(sessionContentExercise, reps, weight);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fitBlueDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.finishSet,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            PreviousRecordsList(
                previousSets: previousExerciseSets
                    .where((FitSet set) => set.record.id != currentRecordId)
                    .toList()),
          ],
        ),
      ),
    );
  }
}
