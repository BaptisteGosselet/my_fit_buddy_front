import 'package:flutter/material.dart';
import 'package:my_fit_buddy/utils/emoji_rating_map.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeelingTextBlock extends StatefulWidget {
  final String text;
  final Function(int, String) onSave;
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
  late String _dropdownValue;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
    _dropdownValue = EmojiRatingMap.instance.getKeyByValue(widget.feelingRate);
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
                if (!_isEditing)
                  Text(
                    _dropdownValue,
                    style: const TextStyle(fontSize: 20),
                  )
                else
                  Container(),
                const SizedBox(width: 16),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 100,
                    child: DropdownMenu<String>(
                      textAlign: TextAlign.center,
                      initialSelection: _dropdownValue,
                      onSelected: (String? value) {
                        setState(() {
                          _dropdownValue = value!;
                        });
                      },
                      dropdownMenuEntries: EmojiRatingMap.instance
                          .getMap()
                          .keys
                          .map<DropdownMenuEntry<String>>((String key) {
                        return DropdownMenuEntry<String>(
                            value: key, label: key);
                      }).toList(),
                    ),
                  ),
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
                      widget.onSave(
                          EmojiRatingMap.instance.getMap()[_dropdownValue]!,
                          _controller.text);
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
