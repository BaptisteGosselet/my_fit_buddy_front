import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key, this.title, required this.onSkip});
  final Function onSkip;
  final String? title;

  @override
  State<TimerPage> createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  final int _duration = 300;
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 25),
          onPressed: () => {print("bye bye")},
          padding: const EdgeInsets.all(8),
          highlightColor: Colors.white.withOpacity(0.1),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            CircularCountDownTimer(
              duration: _duration,
              initialDuration: 0,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: fitBlueDark,
              fillColor: fitBlueMiddle,
              backgroundColor: Colors.white,
              strokeWidth: 20.0,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(
                fontSize: 33.0,
                color: fitBlueMiddle,
                fontWeight: FontWeight.bold,
              ),
              textFormat: CountdownTextFormat.MM_SS,
              isReverse: true,
              isTimerTextShown: true,
              autoStart: true,
              onComplete: () {
                widget.onSkip(); // Corrected function call
              },
              onChange: (String timeStamp) {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 30,
                ),
                _button(
                  title: AppLocalizations.of(context)!.skipButton,
                  onPressed: () => widget.onSkip(), // Corrected function call
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _button({required String title, required VoidCallback onPressed}) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(fitBlueDark),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
