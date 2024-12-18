import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/utils/utils.dart';
import 'package:my_fit_buddy/views/widgets/elementCards/session_card.dart';

class RecordsList extends StatelessWidget {
  final Future<List<FitRecord>> recordsFuture;

  const RecordsList({super.key, required this.recordsFuture});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<List<FitRecord>>(
        future: recordsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur : ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Aucun record trouvé.'),
            );
          } else {
            final records = snapshot.data!;
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return SessionCard(
                  title: record.name,
                  subtitle:
                      'Créé le : ${Utils.instance.getRecordsDateString_1(context, record.date)}',
                  icon: Icons.fitness_center,
                  onTap: () {
                    context.pushNamed(
                      'recordDetails',
                      pathParameters: {'recordId': record.id.toString()},
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
