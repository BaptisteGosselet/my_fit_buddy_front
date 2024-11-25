import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/widgets/headers/play_session_header.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

class PlaySessionPage extends StatelessWidget {
  const PlaySessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [
        PlaySessionHeader(),
      ],
    ));
  }
}
