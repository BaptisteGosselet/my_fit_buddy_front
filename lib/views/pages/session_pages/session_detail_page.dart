import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/models/session.dart';
import 'package:my_fit_buddy/data/models/session_content_exercise.dart';
import 'package:my_fit_buddy/viewmodels/session_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/buttons/fit_button.dart';
import 'package:my_fit_buddy/views/widgets/elementCards/exercise_content_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_fit_buddy/views/widgets/headers/fit_header.dart';

class SessionDetailPage extends StatefulWidget {
  final String id;
  const SessionDetailPage({super.key, required this.id});

  @override
  SessionDetailPageState createState() => SessionDetailPageState();
}

class SessionDetailPageState extends State<SessionDetailPage> {
  late Future<Session> _session;
  late Future<List<SessionContentExercise>> _sessionContents;

  @override
  void initState() {
    super.initState();
    _fetchSession();
    _fetchSessionContents();
  }

  void _fetchSessionContents() {
    _sessionContents = SessionViewmodel().getSessionContents(widget.id);
  }

  void _fetchSession() {
    _session = SessionViewmodel().getSessionByID(widget.id);
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
              final Session sessionInformation = snapshot.data!;
              print("Session : $sessionInformation ");
              return FutureBuilder<List<SessionContentExercise>>(
                  future: _sessionContents,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print("has error");
                      return Center(child: Text('Erreur : ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      print("!hasData");
                      return const Center(
                          child: Text('Aucune session disponible'));
                    } else {
                      List<SessionContentExercise> sessionContents =
                          snapshot.data!;

                      return Column(children: [
                        FitHeader(
                          title: sessionInformation.name,
                          subtitle:
                              "${sessionContents.length.toString()} ${AppLocalizations.of(context)!.exercises}",
                          leftIcon: Icons.arrow_back_ios,
                          rightIcon: Icons.edit,
                          onLeftIconPressed: () => {context.pop()},
                          onRightIconPressed: () => {print("edit${widget.id}")},
                        ),
                        // List SessionContent
                        SizedBox(
                          height: 400,
                          child: ReorderableListView(
                              children: sessionContents
                                  .map((item) => ExerciseContentCard(
                                      key: ValueKey(item.id), content: item))
                                  .toList(),
                              onReorder: (int start, int current) {
                                // dragging from top to bottom
                                if (start < current) {
                                  int end = current - 1;
                                  SessionContentExercise startItem =
                                      sessionContents[start];
                                  int i = 0;
                                  int local = start;
                                  do {
                                    sessionContents[local] =
                                        sessionContents[++local];
                                    i++;
                                  } while (i < end - start);
                                  sessionContents[end] = startItem;
                                }
                                // dragging from bottom to top
                                else if (start > current) {
                                  SessionContentExercise startItem =
                                      sessionContents[start];
                                  for (int i = start; i > current; i--) {
                                    sessionContents[i] = sessionContents[i - 1];
                                  }
                                  sessionContents[current] = startItem;
                                }
                                setState(() {});
                              }),

                          // ListView.builder(
                          //   itemCount: sessionContents.length,
                          //   itemBuilder: (context, index) {
                          //     final sessContent = sessionContents[index];
                          //     print(sessContent.toString());
                          //     return Text("Session: ${sessContent.toString()}");
                          //   },
                          // ),
                        ),
                        const Spacer(),
                        // Bottom Buttons
                        Column(
                          children: [
                            FitButton(
                                buttonColor: fitBlueDark,
                                label:
                                    AppLocalizations.of(context)!.newExercise,
                                onClick: () async {
                                  await context.pushNamed(
                                    'exercises',
                                    pathParameters: {
                                      'idSession': widget.id.toString()
                                    },
                                  );
                                  setState(() {
                                    _fetchSessionContents();
                                  });
                                }),
                            FitButton(
                                buttonColor: fitBlueMiddle,
                                label: AppLocalizations.of(context)!.runSession,
                                onClick: () =>
                                    {context.pushNamed('playSession')}),
                          ],
                        ),
                      ]);
                    }
                  });
            }));
  }
}
