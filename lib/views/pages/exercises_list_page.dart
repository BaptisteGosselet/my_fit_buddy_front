import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/data/exercises/muscle_groups.dart';
import 'package:my_fit_buddy/viewmodels/exercises_viewmodel.dart';
import 'package:my_fit_buddy/viewmodels/session_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/elementCards/exercises_card.dart';
import 'package:my_fit_buddy/views/widgets/inputs/fit_dropdown.dart';
import 'package:my_fit_buddy/views/widgets/headers/fit_header.dart';
import 'package:my_fit_buddy/views/widgets/inputs/fit_search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExercisesListPage extends StatefulWidget {
  final int idSession;
  const ExercisesListPage({super.key, required this.idSession});

  @override
  ExercisesListPageState createState() => ExercisesListPageState();
}

class ExercisesListPageState extends State<ExercisesListPage> {
  final ExercisesViewmodel exercisesViewmodel = ExercisesViewmodel();
  final SessionViewmodel sessionViewmodel = SessionViewmodel();
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
    }).toList()
          ..sort((e1, e2) => muscleOptionCompare(e1['label']!, e2['label']!));

    final ScrollController scrollController = ScrollController();
    scrollController.addListener(() => handleScroll(scrollController));

    return Scaffold(
      backgroundColor: fitCloudWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FitHeader(
              title: AppLocalizations.of(context)!.exercisesTitle,
              leftIcon: Icons.arrow_back_ios,
              onLeftIconPressed: () => {context.pop()},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: FitSearchBar(
              controller: searchController,
              onSearchChanged: (_) {
                setState(() {
                  currentPage = 0;
                  exercises.clear();
                });
                fetchExercises();
              },
            ),
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
                const Spacer()
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
                  onTap: (int idExercise, int nbSet, int restSeconds) => {
                    sessionViewmodel.createNewSessionContent(
                        widget.idSession, idExercise, nbSet, restSeconds)
                  },
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

  int muscleOptionCompare(String s1, String s2) {
    if ((s1.substring(0, 1).compareTo('É') == 0 ||
            s1.substring(0, 1).compareTo('È') == 0) &&
        (s2.substring(0, 1).compareTo('É') == 0 ||
            s2.substring(0, 1).compareTo('È') == 0)) {
      return ('E${s1.substring(1, s1.length)}')
          .compareTo('E${s2.substring(1, s2.length)}');
    }
    if (s1.substring(0, 1).compareTo('É') == 0 ||
        s1.substring(0, 1).compareTo('È') == 0) {
      return ('E${s1.substring(1, s1.length)}').compareTo(s2);
    }
    if (s2.substring(0, 1).compareTo('É') == 0 ||
        s2.substring(0, 1).compareTo('È') == 0) {
      return s1.compareTo('E${s2.substring(1, s2.length)}');
    }
    return s1.compareTo(s2);
  }
}
