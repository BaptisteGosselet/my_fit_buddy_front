import 'package:flutter/material.dart';
import 'package:my_fit_buddy/viewmodels/sessions_list_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:my_fit_buddy/views/widgets/session_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SessionsListPage extends StatelessWidget {
  const SessionsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var sessionsListViewModel = SessionsListViewmodel();

    return Scaffold(
      body: Column(
        children: [
          //TODO : Widget à isoler et travailler (et peut-être déplacer dans home_page)
          Container(
            width: double.infinity,
            color: fitBlueDark,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "myFitBuddy",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 18,
                    fontWeight: fitWeightBold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.sessionListSubtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var session in sessionsListViewModel.getSessionsList())
                      SessionCard(
                        title: session.name,
                        subtitle: "X exercices",
                        icon: Icons.fitness_center_rounded,
                        onTap: () {
                          print(session.name);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
