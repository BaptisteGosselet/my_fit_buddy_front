import 'package:flutter/material.dart';
import 'package:my_fit_buddy/data/models/session_content_models/session_content_exercise.dart';
import 'package:my_fit_buddy/managers/toast_manager.dart';
import 'package:my_fit_buddy/viewmodels/live_session_viewmodel.dart';
import 'package:my_fit_buddy/views/pages/live_session_pages/parts_pages/note_page.dart';
import 'package:my_fit_buddy/views/pages/live_session_pages/parts_pages/play_session_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_fit_buddy/views/pages/live_session_pages/parts_pages/timer_page.dart';
import 'package:my_fit_buddy/views/widgets/exercise_card_scroll.dart';
import 'package:my_fit_buddy/views/widgets/modals/change_live_set.dart';

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
  late int currentSetIndex;

  @override
  void initState() {
    super.initState();
    liveSessionViewmodel = LiveSessionViewmodel(widget.sessionId);
    currentSetIndex = liveSessionViewmodel.getCurrentSetIndex();
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
      setState(() {
        currentSetIndex = liveSessionViewmodel.getCurrentSetIndex();
      });
      switchPage(0);
    } else {
      switchPage(2);
    }
  }

  Future<bool?> showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const ChangeLiveSet();
      },
    );
  }

  void goToSet(int setNumber) async {
    print("ici $setNumber");

    bool? result = await showConfirmationDialog(context);

    if (result == true) {
      liveSessionViewmodel.setFitSetIndex(setNumber);
      setState(() {
        currentSetIndex = liveSessionViewmodel.getCurrentSetIndex();
      });
    }
  }

  void goToExercice(int exerciceNumber) async {
    print("ici $exerciceNumber");

    if (exerciceNumber == liveSessionViewmodel.getCurrentExerciseIndex()) {
      return;
    }

    bool? result = await showConfirmationDialog(context);

    if (result == true) {
      liveSessionViewmodel.setExerciseIndex(exerciceNumber);
      liveSessionViewmodel.setFitSetIndex(0);
      setState(() {
        currentSetIndex = liveSessionViewmodel.getCurrentSetIndex();
      });
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
        sessionContentExercise: currentContent,
        onFinishClick: goToTimer,
        onSetPressed: goToSet,
        currentSetNumber: currentSetIndex,
      );
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
          ExerciseCardScroll(
            exercises: liveSessionViewmodel.getExercisesList(),
            goToExercise: goToExercice,
          ),
        ],
      ),
    );
  }
}
