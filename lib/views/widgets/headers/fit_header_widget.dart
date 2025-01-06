import 'package:flutter/material.dart';
import 'package:my_fit_buddy/managers/toast_manager.dart';
import 'package:my_fit_buddy/viewmodels/session_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:my_fit_buddy/views/widgets/modals/delete_session_content_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FitHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? leftIcon;
  final Widget? rightIcon;
  final VoidCallback? onLeftIconPressed;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final int sessionId;

  const FitHeaderWidget({
    super.key,
    required this.title,
    this.subtitle = '',
    this.leftIcon,
    this.rightIcon,
    this.onLeftIconPressed,
    required this.onUpdate,
    required this.onDelete,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    const double iconSize = 25;
    Color highlightColor = Colors.white.withOpacity(0.1);

    Widget? buildIcon(IconData? icon, VoidCallback? onPressed) {
      return icon == null
          ? null
          : IconButton(
              icon: Icon(icon, color: Colors.white, size: iconSize),
              onPressed: onPressed,
              padding: const EdgeInsets.all(8),
              highlightColor: highlightColor,
            );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 30, bottom: 16, left: 10, right: 10),
      color: fitBlueDark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildIcon(leftIcon, onLeftIconPressed) ?? const SizedBox.shrink(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: fitWeightBold,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.create, color: Colors.white, size: iconSize),
                  onPressed: onUpdate,
                  padding: const EdgeInsets.all(8),
                  highlightColor: highlightColor,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white, size: iconSize),
                  onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DeleteSessionContentDialog(
                              onConfirm: (id) async {
                                bool isDeleted =
                                    await SessionViewmodel().deleteSession(id);
                                if (isDeleted) {
                                  onDelete();
                                } else {
                                  if (context.mounted) {
                                    ToastManager.instance.showErrorToast(
                                        context,
                                        AppLocalizations.of(context)!
                                            .registerUsernameTooLong);
                                  }
                                }
                              },
                              id: sessionId);
                        },
                      ),
                  padding: const EdgeInsets.all(8),
                  highlightColor: highlightColor,
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}
