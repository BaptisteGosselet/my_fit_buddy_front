import 'package:flutter/material.dart';
import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set.dart';
import 'package:my_fit_buddy/viewmodels/exercises_sets_viewmodel.dart';
import 'package:my_fit_buddy/views/widgets/headers/exercise_header.dart';
import 'package:my_fit_buddy/views/widgets/previous_records_widget/all_version/previous_records_list_all.dart';

class ExerciseSetsDetailPage extends StatelessWidget {
  final int exerciseId;

  ExerciseSetsDetailPage({super.key, required this.exerciseId});

  final ExerciseSetsViewmodel exerciseSetsViewmodel = ExerciseSetsViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Exercise>(
        future: exerciseSetsViewmodel.getExerciseById(exerciseId),
        builder: (context, exerciseSnapshot) {
          if (exerciseSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (exerciseSnapshot.hasError) {
            return Center(
              child: Text(
                'Error loading exercise: ${exerciseSnapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!exerciseSnapshot.hasData) {
            return const Center(
              child: Text(
                'No exercise found',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          final exercise = exerciseSnapshot.data!;

          return FutureBuilder<List<FitSet>>(
            future: exerciseSetsViewmodel.getPreviousSetsOfExercise(exerciseId),
            builder: (context, setsSnapshot) {
              if (setsSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (setsSnapshot.hasError) {
                return Center(
                  child: Text(
                    'Error loading fit sets: ${setsSnapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (!setsSnapshot.hasData || setsSnapshot.data!.isEmpty) {
                return Column(
                  children: [
                    ExerciseHeader(exercise: exercise),
                    const Center(
                      child: Text(
                        'No previous sets found for this exercise.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                );
              }

              final previousSets = setsSnapshot.data!;
              return Column(
                children: [
                  ExerciseHeader(exercise: exercise),
                  Expanded(
                    child: PreviousRecordsListAll(previousSets: previousSets),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
