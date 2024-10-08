import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

class SessionsListPage extends StatelessWidget {
  const SessionsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fitCloudWhite,
      child: const Center(
          child: Text('Sessions List Page',
              style: TextStyle(color: Colors.black))),
    );
  }
}
