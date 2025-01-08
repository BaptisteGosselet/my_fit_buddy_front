import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    super.key,
    this.title,
    required this.onValidate,
  });

  final String? title;
  final Future<bool> Function(String text, BuildContext c) onValidate;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.note),
                  TextField(
                    controller: _textController,
                    maxLines: 12,
                    maxLength: 255,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText:
                          AppLocalizations.of(context)!.textNotePlaceholder,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: fitBlueDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4,
                        shadowColor: Colors.grey.withOpacity(0.5),
                      ),
                      onPressed: () async {
                        final text = _textController.text;
                        final success = await widget.onValidate(text, context);

                        if (mounted && success) {
                          if (context.mounted) {
                            context.goNamed('home');
                          }
                        }
                      },
                      child: SizedBox(
                        width: 130,
                        height: 60,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.validateButton,
                            style: const TextStyle(
                              color: fitCloudWhite,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
