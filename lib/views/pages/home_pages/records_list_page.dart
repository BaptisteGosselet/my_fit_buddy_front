import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/utils/utils.dart';
import 'package:my_fit_buddy/viewmodels/records_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/headers/fit_header.dart';
import 'package:my_fit_buddy/views/widgets/elementCards/session_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecordsListPage extends StatefulWidget {
  const RecordsListPage({super.key});

  @override
  RecordsListPageState createState() => RecordsListPageState();
}

class RecordsListPageState extends State<RecordsListPage> {
  late Future<List<FitRecord>> _recordsFuture;

  @override
  void initState() {
    super.initState();
    _recordsFuture = RecordsViewmodel().fetchUserRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FitHeader(
            title: AppLocalizations.of(context)!.recordListTitle,
            subtitle: AppLocalizations.of(context)!.recordListSubtitle,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder<List<FitRecord>>(
                future: _recordsFuture,
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
                          title: 'Record ${record.id}',
                          subtitle:
                              'Créé le : ${Utils.instance.getRecordsDateString(context, record.date)}',
                          icon: Icons.fitness_center,
                          onTap: () {
                            context.pushNamed(
                              'recordDetails',
                              pathParameters: {
                                'recordId': record.id.toString()
                              },
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Add new record');
        },
        backgroundColor: fitBlueDark,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35.0,
        ),
      ),
    );
  }
}
