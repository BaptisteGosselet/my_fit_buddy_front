import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

class RecordsListPage extends StatelessWidget {
  const RecordsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fitCloudWhite,
      child: const Center(
          child:
              Text('Records List Page', style: TextStyle(color: Colors.black))),
    );
  }
}
