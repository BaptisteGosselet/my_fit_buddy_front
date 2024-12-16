import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set.dart';
import 'package:my_fit_buddy/utils/utils.dart';
import 'package:my_fit_buddy/viewmodels/records_viewmodel.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/elementCards/record_exo_card.dart';
import 'package:my_fit_buddy/views/widgets/headers/fit_header.dart';
import 'package:my_fit_buddy/views/pages/records_pages/feeling_text_block.dart';

class RecordsDetailPage extends StatefulWidget {
  final int recordId;

  const RecordsDetailPage({super.key, required this.recordId});

  @override
  RecordsDetailPageState createState() => RecordsDetailPageState();
}

class RecordsDetailPageState extends State<RecordsDetailPage> {
  final recordsViewmodel = RecordsViewmodel();
  late Future<FitRecord> record;
  late Future<Map<String, List<FitSet>>> mapExerciseSet;

  @override
  void initState() {
    super.initState();
    record = recordsViewmodel.getRecordById(widget.recordId).then((result) {
      mapExerciseSet = recordsViewmodel.getSetByExerciceByRecordId(result.id);
      return result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FitRecord>(
      future: record,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Erreur: ${snapshot.error}')),
          );
        } else if (snapshot.hasData) {
          final FitRecord recordData = snapshot.data!;

          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                FitHeader(
                  title: recordData.name,
                  leftIcon: Icons.arrow_back_ios,
                  onLeftIconPressed: () => context.pop(),
                ),

                // Date et heure
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Le ${recordData.date.day} ${Utils.instance.getMonthFull(context, recordData.date.month)} ${recordData.date.year}',
                          style: const TextStyle(
                              fontSize: 17, color: fitBlueMiddle)),
                      Text(
                        '${recordData.date.hour.toString().padLeft(2, '0')}:${recordData.date.minute.toString().padLeft(2, '0')}',
                        style:
                            const TextStyle(fontSize: 17, color: fitBlueMiddle),
                      ),
                    ],
                  ),
                ),

                FeelingTextBlock(
                  text: recordData.feelingNote,
                  feelingRate: recordData.feelingRate,
                  onSave: (int feelingRate, String feelingNote) {
                    recordsViewmodel.saveNote(
                        recordData.id, feelingRate, feelingNote, context);
                  },
                ),

                Expanded(
                  child: FutureBuilder<Map<String, List<FitSet>>>(
                    future: mapExerciseSet,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Erreur: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final Map<String, List<FitSet>> recordDataExo =
                            snapshot.data!;
                        return ListView.builder(
                          itemCount: recordDataExo.length,
                          itemBuilder: (context, index) {
                            String key = recordDataExo.keys.elementAt(index);
                            return RecordExoCard(
                              title: key,
                              subtitle: Column(
                                children: List.generate(
                                  recordDataExo[key]!.length,
                                  (exoIndex) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${exoIndex + 1}      ${recordDataExo[key]![exoIndex].nbRep} x ${recordDataExo[key]![exoIndex].weight} kg",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                final fitSet = recordDataExo[key]![0];
                                context.pushNamed(
                                  'exerciseSetsDetail',
                                  pathParameters: {
                                    'exerciseId': fitSet.exercise.id.toString(),
                                  },
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('Aucune donnée disponible.'),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text('Aucune donnée disponible.')),
          );
        }
      },
    );
  }
}
