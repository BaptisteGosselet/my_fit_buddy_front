import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

class SessionDetailPage extends StatefulWidget {
  final String id;

  const SessionDetailPage(
      {super.key,
      required this.id});

  @override
  SessionDetailPageState createState() => SessionDetailPageState();
}

class SessionDetailPageState extends State<SessionDetailPage> {
  @override
  void initState() {
    super.initState();
    // session = SessionViewmodel().getSessionByID(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fitCloudWhite,
      child: Center(
        child: Text('Session Details for ID: ${widget.id}',
            style: const TextStyle(color: fitBlueDark)),
      ),
    );
  }
}
