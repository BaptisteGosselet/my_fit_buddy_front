import 'package:flutter/material.dart';
import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/data/exercises/muscle_groups.dart';
import 'package:my_fit_buddy/viewmodels/exercises_viewmodel.dart';
import 'package:my_fit_buddy/views/widgets/elementCards/exercises_record_card.dart';
import 'package:my_fit_buddy/views/widgets/inputs/fit_dropdown.dart';
import 'package:my_fit_buddy/views/widgets/inputs/fit_search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExercisesRecordsList extends StatefulWidget {
  const ExercisesRecordsList({Key? key}) : super(key: key);

  @override
  ExercisesRecordsListState createState() => ExercisesRecordsListState();
}

class ExercisesRecordsListState extends State<ExercisesRecordsList> {
  final ExercisesViewmodel exercisesViewmodel = ExercisesViewmodel();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController muscleGroupController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  List<Exercise> exercises = [];
  int currentPage = 0;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
    fetchExercises();
  }

  @override
  void dispose() {
    searchController.dispose();
    muscleGroupController.dispose();
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchExercises() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      List<Exercise> newExercises = await exercisesViewmodel.updateExercises(
        searchController.text,
        muscleGroupController.text,
        currentPage,
      );

      setState(() {
        if (newExercises.isNotEmpty) {
          exercises.addAll(newExercises);
          currentPage++;
        } else {
          hasMore = false;
        }
      });
    } catch (error) {
      debugPrint('Erreur lors du chargement des exercices: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void resetAndFetchExercises() {
    setState(() {
      currentPage = 0;
      exercises.clear();
      hasMore = true;
    });
    fetchExercises();
  }

  void onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !isLoading &&
        hasMore) {
      fetchExercises();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> muscleGroupsOptions =
        MuscleGroupsUtils.muscleGroups.map((muscle) {
      final String translatedMuscle =
          MuscleGroupsUtils.translateMuscle(context, muscle.toLowerCase());
      return {
        'label': translatedMuscle,
        'value': muscle,
      };
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FitSearchBar(
              controller: searchController,
              onSearchChanged: (_) => resetAndFetchExercises(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: FitDropdown(
                    title: AppLocalizations.of(context)!.muscleGroupMenu,
                    options: muscleGroupsOptions,
                    controller: muscleGroupController,
                    onItemChanged: resetAndFetchExercises,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: exercises.length + (isLoading ? 1 : 0),
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                if (index == exercises.length && isLoading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (index >= exercises.length) return const SizedBox.shrink();
                final exercise = exercises[index];
                return ExerciseRecordCard(exercise: exercise);
              },
            ),
          ),
        ],
      ),
    );
  }
}
