import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeelingTextBlock extends StatefulWidget {
  final String text;
  final Function(String) onSave;
  final int feelingRate;

  const FeelingTextBlock({
    super.key,
    required this.text,
    required this.onSave,
    required this.feelingRate,
  });

  @override
  FeelingTextBlockState createState() => FeelingTextBlockState();
}

class FeelingTextBlockState extends State<FeelingTextBlock> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: fitBlueMiddle,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: _isEditing
                        ? TextField(
                            controller: _controller,
                            maxLines: 5,
                            maxLength: 255,
                            decoration: InputDecoration.collapsed(
                              hintText: AppLocalizations.of(context)!
                                  .textNotePlaceholder,
                            ),
                          )
                        : Text(
                            widget.text.isNotEmpty ? widget.text : "no note",
                            style: const TextStyle(fontSize: 14),
                          ),
                  ),
                ),
              ],
            ),
            if (_isEditing)
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    _isEditing ? Icons.close : Icons.edit,
                    color: _isEditing ? Colors.redAccent : fitBlueMiddle,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_isEditing) {
                        _controller.text = widget.text;
                      }
                      _isEditing = !_isEditing;
                    });
                  },
                ),
                if (_isEditing)
                  IconButton(
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      widget.onSave(_controller.text);
                      setState(() {
                        _isEditing = false;
                      });
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
