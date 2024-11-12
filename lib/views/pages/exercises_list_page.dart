import 'package:flutter/material.dart';
import 'package:my_fit_buddy/data/models/exercise.dart';
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

  final Map<String, String> muscleGroupMapping = {
    'Pectoraux': 'PECTORAL',
    'Abdominaux': 'ABDOMINAL',
    'Biceps': 'BICEPS',
    //TODO Ajouter les autres muscles attendus
  };

  @override
  void initState() {
    super.initState();
    _fetchExercises();
  }

  void _fetchExercises() async {
    String selectedMuscleGroup =
        muscleGroupMapping[muscleGroupController.text] ?? '';
    await exercisesViewmodel.updateExercises(
      searchController.text,
      selectedMuscleGroup,
      currentPage,
    );
    setState(() {
      exercises = exercisesViewmodel.exercises;
    });
  }

  void _handleScroll(ScrollController scrollController) {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() => currentPage++);
      _fetchExercises();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    scrollController.addListener(() => _handleScroll(scrollController));

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
            onSearchChanged: (_) => _fetchExercises(),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                FitDropdown(
                  title: 'Muscle Group',
                  options: muscleGroupMapping.keys.toList(),
                  controller: muscleGroupController,
                  onItemChanged: () {
                    currentPage = 0;
                    _fetchExercises();
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
                return ExercisesCard(
                  title: exercise.key,
                  subtitle: exercise
                      .muscleGroup, 
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
