import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/models/session.dart';
import 'package:my_fit_buddy/data/models/session_content_exo_key.dart';
import 'package:my_fit_buddy/viewmodels/session_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/buttons/fit_button.dart';
import 'package:my_fit_buddy/views/widgets/headers/fit_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SessionDetailPage extends StatefulWidget {
  final String? id;
  const SessionDetailPage({super.key, this.id});

  @override
  SessionDetailPageState createState() => SessionDetailPageState();
}

class SessionDetailPageState extends State<SessionDetailPage> {
  late Future<Session> _session;
  late Future<List<SessionContentExoKey>> _sessionContents;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      final id = widget.id!;
      _session = SessionViewmodel().getSessionByID(id);
      _sessionContents = SessionViewmodel().getSessionContents(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: fitCloudWhite,
        body: FutureBuilder<Session>(
            future: _session,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print("hasError");
                return Center(child: Text('Erreur : ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                print("!hasData");
                return const Center(child: Text('Erreur : No Data'));
              }
              final session = snapshot.data!;
              return Column(
                children: [
                  FitHeader(
                    title: session.name,
                    subtitle: "NB EXERCICE", // TODO Number of exercise
                    leftIcon: Icons.arrow_back_ios,
                    rightIcon: Icons.edit,
                    onLeftIconPressed: () => {context.pop()},
                    onRightIconPressed: () => {print("edit${widget.id}")},
                  ),
                  FutureBuilder<List<SessionContentExoKey>>(
                      future: _sessionContents,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print("has error");
                          return Center(
                              child: Text('Erreur : ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          print("!hasData");
                          return const Center(
                              child: Text('Aucune session disponible'));
                        } else {
                          List<SessionContentExoKey> sessionContents =
                              snapshot.data!;
                          return SizedBox(
                            height: 400,
                            child: ListView.builder(
                              itemCount: sessionContents.length,
                              itemBuilder: (context, index) {
                                final session = sessionContents[index];
                                print(session.toString());
                                return Text("Session: ${session.toString()}");
                              },
                            ),
                          );
                        }
                      }),
                  const Spacer(),
                  //Buttons
                  Column(
                    children: [
                      FitButton(
                          buttonColor: fitBlueDark,
                          label: AppLocalizations.of(context)!.newExercise,
                          onClick: () => {context.goNamed('exercises')}),
                      FitButton(
                          buttonColor: fitBlueMiddle,
                          label: AppLocalizations.of(context)!.runSession,
                          onClick: () => {context.goNamed('playSession')}),
                    ],
                  ),
                ],
              );
            }));
  }
}
