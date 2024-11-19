import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/models/session.dart';
import 'package:my_fit_buddy/viewmodels/session_viewmodel.dart';
import 'package:my_fit_buddy/viewmodels/sessions_list_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/fit_header.dart';
import 'package:my_fit_buddy/views/widgets/elementCards/session_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SessionsListPage extends StatefulWidget {
  const SessionsListPage({super.key});

  @override
  SessionsListPageState createState() => SessionsListPageState();
}

class SessionsListPageState extends State<SessionsListPage> {
  late Future<List<Session>> _sessionsFuture;

  @override
  void initState() {
    super.initState();
    _sessionsFuture = SessionsListViewmodel().getSessionsList();
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
              child: FutureBuilder<List<Session>>(
                future: _sessionsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erreur : ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Aucune session trouvée.'));
                  } else {
                    final sessions = snapshot.data!;
                    return ListView.builder(
                      itemCount: sessions.length,
                      itemBuilder: (context, index) {
                        final session = sessions[index];
                        return SessionCard(
                          title: session.name,
                          subtitle: "X exercices",
                          icon: Icons.fitness_center_rounded,
                          onTap: () {
                            context.pushNamed(
                              'sessionDetails',
                              pathParameters: {'id': session.id.toString()},
                            );
                          },
                        );
                      },
                    );
                  }
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
          sessionFuture.then((session) {
            if (context.mounted) {
              // context.pushNamed('s',
              //     pathParameters: {'id': session.id.toString()});
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
