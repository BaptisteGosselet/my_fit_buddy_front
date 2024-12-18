import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/models/session_models/session.dart';
import 'package:my_fit_buddy/viewmodels/session_viewmodel.dart';
import 'package:my_fit_buddy/viewmodels/sessions_list_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/headers/fit_header.dart';
import 'package:my_fit_buddy/views/widgets/elementCards/session_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SessionsListPage extends StatefulWidget {
  const SessionsListPage({super.key});

  @override
  SessionsListPageState createState() => SessionsListPageState();
}

class SessionsListPageState extends State<SessionsListPage> {
  List<Session> _sessions = [];
  SessionsListViewmodel sessionsListViewmodel = SessionsListViewmodel();

  @override
  void initState() {
    super.initState();
    _fetchSession();
  }

  _fetchSession() async {
    final sessionsFuture = await SessionsListViewmodel().getSessionsList();
    if (context.mounted) {
      setState(() {
        _sessions = sessionsFuture;
      });
    }
  }

  pushToSessionDetails(String stringId) async {
    await context.pushNamed(
      'sessionDetails',
      pathParameters: {'id': stringId},
    );
    setState(() {
      _fetchSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FitHeader(
              title: AppLocalizations.of(context)!.sessionListTitle,
              subtitle: AppLocalizations.of(context)!.sessionListSubtitle),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _sessions.isEmpty
                  ? Center(
                      child: Text(
                      AppLocalizations.of(context)!.noSessionFound,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ))
                  : ListView.builder(
                      itemCount: _sessions.length,
                      itemBuilder: (context, index) {
                        final session = _sessions[index];
                        return FutureBuilder<int>(
                          future: sessionsListViewmodel
                              .getSessionExercicesNumber(session.id),
                          builder: (context, exerciceSnapshot) {
                            String subtitle =
                                AppLocalizations.of(context)!.isLoading;
                            if (exerciceSnapshot.connectionState ==
                                ConnectionState.done) {
                              if (exerciceSnapshot.hasData) {
                                subtitle = "${exerciceSnapshot.data} exercices";
                              } else {
                                subtitle = "Erreur de données";
                              }
                            }

                            return SessionCard(
                              title: session.name,
                              subtitle: subtitle,
                              icon: Icons.fitness_center_rounded,
                              onTap: () {
                                pushToSessionDetails(session.id.toString());
                              },
                            );
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('add session');
          final sessionFuture = SessionViewmodel()
              .createNewSession(AppLocalizations.of(context)!.newSessionName);
          sessionFuture.then((newSession) {
            if (context.mounted) {
              pushToSessionDetails(newSession.id.toString());
            }
          });
        },
        backgroundColor: fitBlueDark,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35.0,
        ),
      ),
    );
  }
}
