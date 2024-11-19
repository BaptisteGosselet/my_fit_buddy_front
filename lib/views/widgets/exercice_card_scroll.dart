import 'package:flutter/material.dart';
import 'package:my_fit_buddy/core/config.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

void main() => runApp(const ExerciceCardScroll());

class ExerciceCardScroll extends StatelessWidget {
  const ExerciceCardScroll({super.key});
  
  @override
  Widget build(BuildContext context) {

    return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 100,
          child: ListView.separated(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) { 
                return Container(
                decoration: BoxDecoration(
                  color: fitBlueMiddle,
                  border: Border.all(
                    color: fitBlueMiddle,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(7),
                width: 100,
                child: Image.network(
                  '$configBaseAPI/exercises/${7}/image',
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
              );
             },
            separatorBuilder: (BuildContext context, int index) { return const SizedBox(width: 5); },
            itemCount: 10,
          ),
        );
  }
}