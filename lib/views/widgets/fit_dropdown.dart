import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

class FitDropdown extends StatefulWidget {
  final String title;
  final List<String> options;
  final TextEditingController controller;
  final Function()? onItemChanged;

  const FitDropdown({
    super.key,
    required this.title,
    required this.options,
    required this.controller,
    this.onItemChanged,
  });

  @override
  State<FitDropdown> createState() => _FitDropdownState();
}

class _FitDropdownState extends State<FitDropdown> {
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = '';
    widget.controller.clear();
  }

  void clear() {
    setState(() {
      selectedItem = '';
      widget.controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color widgetColor = fitBlueDark;
    const double minWidth = 150.0;

    List<String> dropdownOptions = [''] + widget.options;

    return Container(
      constraints: const BoxConstraints(minWidth: minWidth),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: fitCloudWhite,
        border: Border.all(color: widgetColor, width: 1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            widget.title,
            style: const TextStyle(
              color: widgetColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          value: selectedItem!.isEmpty ? null : selectedItem,
          icon: const Icon(Icons.arrow_drop_down, color: widgetColor),
          items: dropdownOptions.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Text(
                  item.isEmpty ? '' : item,
                  style: TextStyle(
                    color: item.isEmpty ? fitBlueDark : fitBlueDark,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              if (newValue == '') {
                clear(); // Sélectionne « Clear »
              } else {
                selectedItem = newValue;
                widget.controller.text = newValue ?? '';
              }
            });

            if (widget.onItemChanged != null) {
              widget.onItemChanged!();
            }
          },
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          style: const TextStyle(color: widgetColor),
        ),
      ),
    );
  }
}
