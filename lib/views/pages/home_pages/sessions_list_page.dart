import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:my_fit_buddy/views/widgets/session_card.dart';

class SessionsListPage extends StatelessWidget {
  const SessionsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                color: fitBlueDark,
                child: const Text(
                  "Session List Page",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: fitWeightBold,
                  ),
                )),
            SessionCard(
              title: "Séance Full Body",
              subtitle: "7 exercices",
              icon: Icons.fitness_center_rounded, // Icône optionnelle
              onTap: () {
                //print('La carte 1 a été cliquée !');
              },
            ),
            SessionCard(
              title: "Séance Haut du Corps",
              subtitle: "7 exercices",
              icon: Icons.fitness_center_outlined, // Icône optionnelle
              onTap: () {
                //print('La carte 2 a été cliquée !');
              },
            ),
            SessionCard(
              title: "Séance Bas du Corps",
              subtitle: "7 exercices",
              icon: Icons.fitness_center, // Icône optionnelle
              onTap: () {
                //print('La carte 3 a été cliquée !');
              },
            ),
          ],
        ),
      ),
    );
  }
}
