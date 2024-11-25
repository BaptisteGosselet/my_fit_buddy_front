import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/headers/play_session_header.dart';
import 'package:my_fit_buddy/views/widgets/inputs/fit_text_input.dart';
import 'package:my_fit_buddy/views/widgets/previous_records_widget/previous_records_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaySessionPage extends StatelessWidget {
  const PlaySessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController repsTextController = TextEditingController(text: "6");
    TextEditingController weightTextController =
        TextEditingController(text: "45");

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PlaySessionHeader(),
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
                    print(
                        "reps : ${repsTextController.text}, weight : ${weightTextController.text}");
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
            const PreviousRecordsList(),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.green,
              child: const Center(
                child: Text(
                  'Container',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
