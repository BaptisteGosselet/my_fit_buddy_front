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
  List<SessionContentExercise> sessionContents = [];

  @override
  void initState() {
    super.initState();
    _fetchSession();
    _loadSessionContents();
  }

  Future<void> _loadSessionContents() async {
    final contents = await SessionViewmodel().getSessionContents(widget.id);
    if(context.mounted) {
      setState(() {
      sessionContents = contents;
    });
    }
  }

  void _fetchSession() {
    _session = SessionViewmodel().getSessionByID(widget.id);
  }

  void _deleteSessionContent(int id) {
    setState(() {
      sessionContents.removeWhere((content) => content.id == id);
    });
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
                Expanded(
                  child: ReorderableListView(
                      children: sessionContents
                          .map((item) => ExerciseContentCard(
                                key: ValueKey(item.id),
                                content: item,
                                onDelete: () => _deleteSessionContent(item.id),
                              ))
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
                            sessionContents[local] = sessionContents[++local];
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
                ),
                Column(
                  children: [
                    FitButton(
                        buttonColor: fitBlueDark,
                        label: AppLocalizations.of(context)!.newExercise,
                        onClick: () async {
                          await context.pushNamed(
                            'exercises',
                            pathParameters: {'idSession': widget.id.toString()},
                          );
                          setState(() {
                            _loadSessionContents();
                          });
                        }),
                    FitButton(
                        buttonColor: fitBlueMiddle,
                        label: AppLocalizations.of(context)!.runSession,
                        onClick: () => {context.pushNamed('playSession')}),
                    const SizedBox(height: 10)
                  ],
                ),
              ]);
            }));
  }
}
