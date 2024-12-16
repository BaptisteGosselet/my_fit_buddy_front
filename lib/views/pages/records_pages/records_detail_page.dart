import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set.dart';
import 'package:my_fit_buddy/viewmodels/records_viewmodel.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/elementCards/record_exo_card.dart';
import 'package:my_fit_buddy/views/widgets/elementCards/session_card.dart';
import 'package:my_fit_buddy/views/widgets/headers/fit_header.dart';

class RecordsDetailPage extends StatefulWidget {
  final int recordId;

  const RecordsDetailPage({super.key, required this.recordId});

  @override
  RecordsDetailPageState createState() => RecordsDetailPageState();
}

class RecordsDetailPageState extends State<RecordsDetailPage> {
  final recordsViewmodel = RecordsViewmodel();
  late Future<FitRecord> record;
  late Future<Map<String,List<FitSet>>> mapExerciseSet;

  @override
  void initState() {
    super.initState();
    record = recordsViewmodel.getRecordById(widget.recordId).then((FitRecord result) {
      mapExerciseSet = recordsViewmodel.getSetByExerciceByRecordId(result.id);
      return result;
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    const Map<int, String> monthsInYear = {
      1: "Janvier",
      2: "Février",
      3: "Mars",
      4: "Avril",
      5: "Mai",
      6: "Juin",
      7: "Juillet",
      8: "Août",
      9: "Septembre",
      10: "Octobre",
      11: "Novembre",
      12: "Décembre"
    };

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
            //appBar: AppBar(title: const Text('Détails de l\'enregistrement')),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FitHeader(
                    title: recordData.name,
                    leftIcon: Icons.arrow_back_ios,
                    onLeftIconPressed: () => {context.pop()},
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Le ${recordData.date.day} ${monthsInYear[recordData.date.month]} ${recordData.date.year}',
                          style: const TextStyle(fontSize: 17, color: fitBlueMiddle)
                          ),
                        Text(
                          '${recordData.date.hour < 10 ? '0${recordData.date.hour}' : recordData.date.hour}:${recordData.date.minute < 10 ? '0${recordData.date.minute}' : recordData.date.minute}',
                          style: const TextStyle(fontSize: 17, color: fitBlueMiddle)
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<Map<String,List<FitSet>>>(
                    future: mapExerciseSet,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Erreur: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        Map<String,List<FitSet>> recordDataExo = snapshot.data!;
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: recordDataExo.length,
                            itemBuilder: (context, index) {
                              String key = recordDataExo.keys.elementAt(index);
                              return RecordExoCard(
                                title: key,
                                subtitle: Flexible(
                                  child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: recordDataExo[key]!.length,
                                        itemBuilder: (context, index) {
                                         return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                            Text("$index      ${recordDataExo[key]![index].nbRep} x ${recordDataExo[key]![index].weight} kg"),
                                          ]);
                                        }
                                  ),
                                ),
                                onTap: () {
                                  context.pushNamed(
                                    'recordDetails',
                                    pathParameters: {
                                      'recordId': "test"//record.id.toString()
                                    },
                                  );
                                },
                              );
                            },
                        );
                      }else {
                        return const Center(child: Text('Aucune donnée disponible.'));
                      }
                    }
                  )
                ],
              ),
          );
        } else {
          return const Center(child: Text('Aucune donnée disponible.'));
        }
      },
    );
  }
}
