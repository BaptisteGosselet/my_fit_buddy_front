import 'package:flutter/material.dart';
import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/data/exercises/muscle_groups.dart';
import 'package:my_fit_buddy/viewmodels/exercises_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/exercises_card.dart';
import 'package:my_fit_buddy/views/widgets/fit_dropdown.dart';
import 'package:my_fit_buddy/views/widgets/fit_header.dart';
import 'package:my_fit_buddy/views/widgets/fit_search_bar.dart';

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
    final ScrollController scrollController = ScrollController();
    scrollController.addListener(() => handleScroll(scrollController));

    return Scaffold(
      backgroundColor: fitCloudWhite,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FitHeader(
              title: 'TITLE EXERCISES',
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
                  title: 'Muscle Group',
                  options: muscleGroups,
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
                  options: const ['m1', 'm2', 'm3'],
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
