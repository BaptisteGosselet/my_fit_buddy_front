import 'package:flutter/material.dart';
import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/data/exercises/muscle_groups.dart';
import 'package:my_fit_buddy/viewmodels/exercises_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/exercises_card.dart';
import 'package:my_fit_buddy/views/widgets/fit_dropdown.dart';
import 'package:my_fit_buddy/views/widgets/fit_header.dart';
import 'package:my_fit_buddy/views/widgets/fit_search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExercisesListPage extends StatefulWidget {
  const ExercisesListPage({super.key});

  @override
  ExercisesListPageState createState() => ExercisesListPageState();
}

class ExercisesListPageState extends State<ExercisesListPage> {
  final ExercisesViewmodel exercisesViewmodel = ExercisesViewmodel();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController muscleGroupController = TextEditingController();
  final TextEditingController matController = TextEditingController();

  int currentPage = 0;
  List<Exercise> exercises = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    List<Exercise> newExercises = await exercisesViewmodel.updateExercises(
      searchController.text,
      muscleGroupController.text,
      currentPage,
    );

    setState(() {
      if (newExercises.isNotEmpty) {
        exercises.addAll(newExercises);
        currentPage++;
      }
      isLoading = false;
    });
  }

  void handleScroll(ScrollController scrollController) {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchExercises();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> muscleGroupsOptions =
        MuscleGroupsUtils.muscleGroups.map((muscle) {
      final String tradMuscle =
          MuscleGroupsUtils.translateMuscle(context, muscle.toLowerCase());
      return {
        'label': tradMuscle,
        'value': muscle,
      };
    }).toList();

    final List<Map<String, String>> matOptions = [
      {'label': 'Material 1', 'value': 'm1'},
      {'label': 'Material 2', 'value': 'm2'},
      {'label': 'Material 3', 'value': 'm3'},
    ];

    final ScrollController scrollController = ScrollController();
    scrollController.addListener(() => handleScroll(scrollController));

    return Scaffold(
      backgroundColor: fitCloudWhite,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FitHeader(
              title: AppLocalizations.of(context)!.exercisesTitle,
              leftIcon: Icons.arrow_back_ios,
              onLeftIconPressed: () => print('retour'),
            ),
          ),
          FitSearchBar(
            controller: searchController,
            onSearchChanged: (_) {
              setState(() {
                currentPage = 0;
                exercises.clear();
              });
              fetchExercises();
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                FitDropdown(
                  title: AppLocalizations.of(context)!.muscleGroupMenu,
                  options: muscleGroupsOptions,
                  controller: muscleGroupController,
                  onItemChanged: () {
                    setState(() {
                      currentPage = 0;
                      exercises.clear();
                    });
                    fetchExercises();
                  },
                ),
                const Spacer(),
                FitDropdown(
                  title: 'Mat',
                  options: matOptions,
                  controller: matController,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                print(exercise);
                return ExercisesCard(
                  exercise: exercise,
                  onTap: (int id) =>
                      {print('add $id')}, //Todo remplacer par add exercise
                );
              },
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
