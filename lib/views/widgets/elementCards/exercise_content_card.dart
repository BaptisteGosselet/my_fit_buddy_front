import 'package:flutter/material.dart';
import 'package:my_fit_buddy/core/config.dart';
import 'package:my_fit_buddy/data/models/session_content_exercise.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:my_fit_buddy/views/widgets/modals/delete_session_content_dialog.dart';

class ExerciseContentCard extends StatefulWidget {
  const ExerciseContentCard({super.key, required this.content});

  final SessionContentExercise content;

  @override
  ExerciseContentCardState createState() => ExerciseContentCardState();
}

class ExerciseContentCardState extends State<ExerciseContentCard> {
  // bool _isPressed = false;

  // void _handleTap(bool pressed) => setState(() => _isPressed = pressed);

  // void _showConfirmationDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return DeleteSessionContentDialog(
  //           onConfirm: (id) => {print(id)}, id: widget.content.id);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.menu),
          buildLeftSquare(),
          const SizedBox(width: 16),
          buildTextContent(),
          IconButton(
              icon: const Icon(Icons.delete),
              iconSize: 20.0,
              onPressed: () {
                print('Icône de poubelle cliquée !');
              })
        ],
      ),
    );
  }

  Widget buildLeftSquare() {
    return SizedBox(
      width: 90,
      height: 70,
      child: Image.network(
        '$configBaseAPI/exercises/${widget.content.exercise.id}/image',
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
    );
  }

  Widget buildTextContent() {
    final String exerciseLabel = widget.content.exercise.labelFr;

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
          const Row(
            children: [SizedBox(width: 4)],
          ),
        ],
      ),
    );
  }
}
