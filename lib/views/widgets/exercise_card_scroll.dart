import 'package:flutter/material.dart';
import 'package:my_fit_buddy/core/config.dart';
import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

class ExerciseCardScroll extends StatelessWidget {
  final List<Exercise> exercises;
  final Function(int) goToExercise;
  final int currentExerciseIdx;

  const ExerciseCardScroll(
      {super.key,
      required this.exercises,
      required this.goToExercise,
      required this.currentExerciseIdx});

  @override
  Widget build(BuildContext context) {
    const double borderThickness = 1.0;
    const double borderRadius = 3.0;
    const Color defaultBorderColor = fitBlueSky;
    const Color selectedBorderColor = fitBlueMiddle;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          Exercise exercise = exercises[index];

          Color borderColor = (index == currentExerciseIdx)
              ? selectedBorderColor
              : defaultBorderColor;

          return GestureDetector(
            onTap: () => goToExercise(index),
            child: Container(
              decoration: BoxDecoration(
                color: borderColor,
                border: Border.all(
                  color: borderColor,
                  width: borderThickness,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: const EdgeInsets.all(5.0),
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
                  return const Icon(Icons.error, color: Colors.redAccent);
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
