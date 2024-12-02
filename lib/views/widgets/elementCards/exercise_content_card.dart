import 'package:flutter/material.dart';
import 'package:my_fit_buddy/core/config.dart';
import 'package:my_fit_buddy/data/models/session_content_models/session_content_exercise.dart';
import 'package:my_fit_buddy/managers/toast_manager.dart';
import 'package:my_fit_buddy/utils/utils.dart';
import 'package:my_fit_buddy/viewmodels/session_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_fit_buddy/views/widgets/modals/delete_session_content_dialog.dart';

class ExerciseContentCard extends StatefulWidget {
  const ExerciseContentCard(
      {super.key, required this.content, required this.onDelete});

  final SessionContentExercise content;
  final VoidCallback onDelete;

  @override
  ExerciseContentCardState createState() => ExerciseContentCardState();
}

class ExerciseContentCardState extends State<ExerciseContentCard> {
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteSessionContentDialog(
            onConfirm: (id) async {
              bool isDeleted =
                  await SessionViewmodel().deleteSessionContent(id);
              if (isDeleted) {
                widget.onDelete();
              } else {
                if (context.mounted) {
                  ToastManager.instance.showErrorToast(context,
                      AppLocalizations.of(context)!.registerUsernameTooLong);
                }
              }
            },
            id: widget.content.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.menu, color: fitBlueMiddle),
          const SizedBox(width: 10),
          buildLeftSquare(),
          const SizedBox(width: 10),
          Text(
            "${widget.content.numberOfSet}x",
            style: const TextStyle(
              color: fitBlueDark,
              fontSize: 18,
              fontWeight: fitWeightBold,
            ),
          ),
          const SizedBox(width: 10),
          buildTextContent(),
          IconButton(
              icon: const Icon(Icons.delete),
              color: fitBlueDark,
              iconSize: 20.0,
              onPressed: () {
                _showConfirmationDialog(context);
              })
        ],
      ),
    );
  }

  Widget buildLeftSquare() {
    return SizedBox(
      width: 80,
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
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
          Row(
            children: [
              const Icon(Icons.access_time, size: 18, color: fitBlueMiddle),
              const SizedBox(width: 2),
              Text(
                  Utils.instance.convertSecondsToStringTime(
                      widget.content.restTimeInSecond),
                  style: const TextStyle(
                    color: fitBlueMiddle,
                    fontSize: 14,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
