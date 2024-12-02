import 'package:flutter/material.dart';
import 'package:my_fit_buddy/viewmodels/records_viewmodel.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';

class RecordsDetailPage extends StatefulWidget {
  final int recordId;

  const RecordsDetailPage({super.key, required this.recordId});

  @override
  RecordsDetailPageState createState() => RecordsDetailPageState();
}

class RecordsDetailPageState extends State<RecordsDetailPage> {
  final recordsViewmodel = RecordsViewmodel();
  late Future<FitRecord> record;

  @override
  void initState() {
    super.initState();
    record = recordsViewmodel.getRecordById(widget.recordId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FitRecord>(
      future: record,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          FitRecord recordData = snapshot.data!;
          return Scaffold(
            appBar: AppBar(title: const Text('Détails de l\'enregistrement')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${recordData.id}'),
                  Text('Date: ${recordData.date}'),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('Aucune donnée disponible.'));
        }
      },
    );
  }
}
