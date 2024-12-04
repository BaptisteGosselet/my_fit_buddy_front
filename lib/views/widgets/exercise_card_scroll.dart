import 'package:flutter/material.dart';
import 'package:my_fit_buddy/core/config.dart';
import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

class ExerciseCardScroll extends StatelessWidget {
  final List<Exercise> exercises;
  final Function(int) goToExercice;

  const ExerciseCardScroll(
      {super.key, required this.exercises, required this.goToExercice});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          Exercise exercise = exercises[index];

          return GestureDetector(
            onTap: () => goToExercice(index),
            child: Container(
              decoration: BoxDecoration(
                color: fitBlueMiddle,
                border: Border.all(
                  color: fitBlueMiddle,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(7),
              width: 100,
              child: Image.network(
                '$configBaseAPI/exercises/${exercise.id}/image',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.red);
                },
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 5);
        },
        itemCount: exercises.length,
      ),
    );
  }
}
