import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/exercises_card.dart';
import 'package:my_fit_buddy/views/widgets/fit_dropdown.dart';
import 'package:my_fit_buddy/views/widgets/fit_header.dart';
import 'package:my_fit_buddy/views/widgets/fit_search_bar.dart';

class ExercisesListPage extends StatelessWidget {
  const ExercisesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: 'Controller');

    final TextEditingController dropController = TextEditingController();
    final TextEditingController dropController2 = TextEditingController();

    return Scaffold(
      backgroundColor: fitCloudWhite,
      body: Column(
        children: [
          // Header fixe
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FitHeader(
              title: 'TITLE EXERCISES',
              leftIcon: Icons.arrow_back_ios,
              onLeftIconPressed: () => print('retour'),
            ),
          ),
          
          // Barre de recherche fixe
          FitSearchBar(controller: controller),

          // Espace entre la barre de recherche et la Row des menus
          const SizedBox(height: 16), // Espace ajouté ici

          // Row avec les dropdowns, fixe
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                FitDropdown(
                  title: 'gmuscle',
                  options: const ['g1', 'g2', 'g3'],
                  controller: dropController,
                  onItemChanged: () => print('v${dropController.text}'),
                ),
                const Spacer(),
                FitDropdown(
                  title: 'mat',
                  options: const ['m1', 'm2', 'm3'],
                  controller: dropController2,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8), // Espace ajouté ici

          // Partie scrollable pour la liste des exercices
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Nombre d'items
              itemBuilder: (context, index) {
                return const ExercisesCard(
                  title: 'dev couché',
                  subtitle: 'pecto',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
