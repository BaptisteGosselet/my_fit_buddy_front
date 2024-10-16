import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/fit_header.dart';

class SessionDetailPage extends StatefulWidget {
  final String id;

  const SessionDetailPage({super.key, required this.id});

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
    return Scaffold(
        backgroundColor: fitCloudWhite,
        body: Column(
          children: [
            FitHeader(
              title: "SESSION.NAME",
              subtitle: "NB EXERCICE",
              leftIcon: Icons.arrow_back_ios,
              rightIcon: Icons.edit,
              onLeftIconPressed: () => {context.goNamed('home')},
              onRightIconPressed: () => {print("edit${widget.id}")},
            ),
            Center(
              child: Text('Session Details for ID: ${widget.id}',
                  style: const TextStyle(color: fitBlueDark)),
            ),
          ],
        ));
  }
}
