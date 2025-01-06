import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/core/config.dart';
import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/utils/utils.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';

class ExerciseHeader extends StatelessWidget {
  final Exercise exercise;

  const ExerciseHeader({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    const double squareSize = 100;
    return Column(
      children: [
        Container(
          color: fitBlack,
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Container(
                      height: squareSize,
                      width: squareSize,
                      decoration: BoxDecoration(
                        border: Border.all(color: fitBlueMiddle, width: 2),
                      ),
                      child: Image.network(
                        '$configBaseAPI/exercises/${exercise.id}/image',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error,
                              color: Colors.redAccent);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AutoSizeText(
                        Utils.instance
                            .getTranslatedExerciseLabel(context, exercise),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: fitWeightSemiBold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        minFontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 6.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
