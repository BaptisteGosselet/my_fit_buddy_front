import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_fit_buddy/views/widgets/exercice_card_scroll.dart';

const List<String> list = <String>['🤷‍♂️', '😐', '👍', '😎'];

class NotePage extends StatefulWidget {
  const NotePage({super.key, this.title});

  final String? title;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> with SingleTickerProviderStateMixin {

  late final CustomTimerController _controller = CustomTimerController(
    vsync: this,
    begin: const Duration(minutes: 3),
    end: const Duration(),
    initialState: CustomTimerState.reset,
    interval: CustomTimerInterval.milliseconds
  );

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    _controller.start();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 25),
          onPressed: () => context.goNamed('home'),
          padding: const EdgeInsets.all(8),
          highlightColor: Colors.white.withOpacity(0.1),
        ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTimer(
                  controller: _controller,
                  builder: (state, time) {
                    // Build the widget you want!🎉
                    return Text(
                      "${time.minutes}:${time.seconds}",
                      style: const TextStyle(fontSize: 70.0, color: fitBlueMiddle)
                    );
                  }
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("NOTES"),
                    TextField(
                      maxLines: 12,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: AppLocalizations.of(context)!.textNotePlaceholder,
                      ),
                    ),
                  ],
                ),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownMenu<String>(
                      textAlign: TextAlign.center,
                      initialSelection: list.first,
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(value: value, label: value);
                      }).toList(),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: fitBlueDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        
                      ),
                      onPressed: () {
                        context.goNamed('home'); //TODO
                      },
                      child: SizedBox(
                        width: 130,
                        height: 60,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.validateButton,
                            style: const TextStyle(
                              color: fitCloudWhite,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                  ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: ExerciceCardScroll()
              ),
          ],
        ),
      );
  }
}
