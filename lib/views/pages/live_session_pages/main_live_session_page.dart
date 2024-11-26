import 'package:flutter/material.dart';
import 'package:my_fit_buddy/managers/toast_manager.dart';
import 'package:my_fit_buddy/viewmodels/live_session_viewmodel.dart';
import 'package:my_fit_buddy/views/pages/live_session_pages/play_session_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainLiveSessionPage extends StatefulWidget {
  final String sessionId;

  const MainLiveSessionPage({super.key, required this.sessionId});

  @override
  MainLiveSessionPageState createState() => MainLiveSessionPageState();
}

class MainLiveSessionPageState extends State<MainLiveSessionPage> {
  late LiveSessionViewmodel viewmodel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    viewmodel = LiveSessionViewmodel(widget.sessionId);
    print("live${viewmodel.sessionId}");
    initViewmodel();
  }

  Future<void> initViewmodel() async {
    final success = await viewmodel.init();
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

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return PlaySessionPage();
  }
}
