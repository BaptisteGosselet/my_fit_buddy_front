import 'package:flutter/material.dart';
import 'package:my_fit_buddy/data/models/session.dart';
import 'package:my_fit_buddy/viewmodels/session_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

class SessionDetailPage extends StatefulWidget {
  const SessionDetailPage({super.key});

  @override
  SessionDetailPageState createState() => SessionDetailPageState();
}

class SessionDetailPageState extends State<SessionDetailPage> {
  late Future<Session> _sessionFuture;
  String id = "id"; // TODO PASS ID IN PARAM

  @override
  void initState() {
    super.initState();
    // _sessionFuture = SessionViewmodel().getSessionByID(id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fitCloudWhite,
      child: const Center(
          child: Text('Session Details', style: TextStyle(color: fitBlueDark))),
    );
  }
}
