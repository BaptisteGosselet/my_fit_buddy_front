import 'package:flutter/material.dart';
import 'package:my_fit_buddy/data/models/session_content_models/session_content_exercise.dart';
import 'package:my_fit_buddy/managers/toast_manager.dart';
import 'package:my_fit_buddy/viewmodels/live_session_viewmodel.dart';
import 'package:my_fit_buddy/views/pages/live_session_pages/parts_pages/note_page.dart';
import 'package:my_fit_buddy/views/pages/live_session_pages/parts_pages/play_session_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_fit_buddy/views/pages/live_session_pages/parts_pages/timer_page.dart';
import 'package:my_fit_buddy/views/widgets/exercice_card_scroll.dart';

class MainLiveSessionPage extends StatefulWidget {
  final String sessionId;

  const MainLiveSessionPage({super.key, required this.sessionId});

  @override
  MainLiveSessionPageState createState() => MainLiveSessionPageState();
}

class MainLiveSessionPageState extends State<MainLiveSessionPage> {
  late LiveSessionViewmodel liveSessionViewmodel;
  bool isLoading = true;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    liveSessionViewmodel = LiveSessionViewmodel(widget.sessionId);
    print("live${liveSessionViewmodel.sessionId}");
    initViewmodel();
  }

  Future<void> initViewmodel() async {
    final success = await liveSessionViewmodel.init();
    if (!context.mounted) return;

    if (!success) {
      handleSessionEmpty();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void handleSessionEmpty() {
    ToastManager.instance.showErrorToast(
      context,
      AppLocalizations.of(context)!.sessionEmpty,
    );
    Navigator.pop(context);
  }

  void switchPage(int i) {
    setState(() {
      currentIndex = i;
    });
  }

  void goToTimer(
      SessionContentExercise sessionContentExercise, int reps, int kg) {
    liveSessionViewmodel.saveRecord(sessionContentExercise, reps, kg);
    switchPage(1);
  }

  void goToNextExercise() {
    bool hasNext = liveSessionViewmodel.next();
    if (hasNext) {
      switchPage(0);
    } else {
      switchPage(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    Widget currentPage;
    SessionContentExercise currentContent =
        liveSessionViewmodel.getCurrentSessionContentExercise();
    if (currentIndex == 0) {
      currentPage = PlaySessionPage(
          sessionContentExercise: currentContent, onFinishClick: goToTimer);
    } else if (currentIndex == 1) {
      currentPage = TimerPage(
          duration: currentContent.restTimeInSecond, onSkip: goToNextExercise);
    } else if (currentIndex == 2) {
      currentPage = const NotePage();
    } else {
      currentPage = Container(
        color: Colors.red,
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: currentPage),
          const ExerciceCardScroll(),
        ],
      ),
    );
  }
}
