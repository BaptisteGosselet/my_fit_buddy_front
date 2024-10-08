import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fitCloudWhite,
      child: const Center(
          child: Text('Settings Page', style: TextStyle(color: Colors.black))),
    );
  }
}
