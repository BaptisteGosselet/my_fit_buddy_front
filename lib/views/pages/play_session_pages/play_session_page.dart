import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_fit_buddy/views/widgets/headers/play_session_header.dart';
import 'package:my_fit_buddy/views/widgets/inputs/fit_text_input.dart';
import 'package:my_fit_buddy/views/widgets/previous_records_widget/previous_records_list.dart';

class PlaySessionPage extends StatelessWidget {
  const PlaySessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController repsTextController = TextEditingController();
    TextEditingController weightTextController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PlaySessionHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: FitTextInput(
                      label: "TRep",
                      controller: repsTextController,
                      hintText: "0",
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FitTextInput(
                      label: "TKG",
                      controller: weightTextController,
                      hintText: "0",
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const PreviousRecordsList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
