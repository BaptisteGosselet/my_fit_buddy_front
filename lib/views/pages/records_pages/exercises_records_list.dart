import 'package:flutter/material.dart';

class ExercisesRecordsList extends StatelessWidget {
  const ExercisesRecordsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Contenu du Container Bleu',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}