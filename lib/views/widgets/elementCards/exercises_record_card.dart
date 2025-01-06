import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/core/config.dart';
import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/data/exercises/muscle_groups.dart';
import 'package:my_fit_buddy/utils/utils.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';

class ExerciseRecordCard extends StatefulWidget {
  const ExerciseRecordCard({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  ExercisesCardState createState() => ExercisesCardState();
}

class ExercisesCardState extends State<ExerciseRecordCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          print("${widget.exercise}");

          context.pushNamed(
            'exerciseSetsDetail',
            pathParameters: {
              'exerciseId': widget.exercise.id.toString(),
            },
          );
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildLeftSquare(),
              const SizedBox(width: 16),
              buildTextContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLeftSquare() {
    return SizedBox(
      width: 90,
      height: 70,
      child: Image.network(
        '$configBaseAPI/exercises/${widget.exercise.id}/image',
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
    );
  }

  Widget buildTextContent() {
    final String exerciseLabel =
        Utils.instance.getTranslatedExerciseLabel(context, widget.exercise);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exerciseLabel,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: fitWeightBold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 4),
              Text(
                MuscleGroupsUtils.translateMuscle(
                    context, widget.exercise.muscleGroup.toLowerCase()),
                style: const TextStyle(
                  color: fitBlueMiddle,
                  fontSize: 16,
                  fontWeight: fitWeightMedium,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
