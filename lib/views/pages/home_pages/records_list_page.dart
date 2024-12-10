import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/utils/utils.dart';
import 'package:my_fit_buddy/viewmodels/records_viewmodel.dart';
import 'package:my_fit_buddy/views/pages/records_pages/exercises_records_list.dart';
import 'package:my_fit_buddy/views/pages/records_pages/records_list.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/headers/fit_header.dart';
import 'package:my_fit_buddy/views/widgets/elementCards/session_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecordsListPage extends StatefulWidget {
  const RecordsListPage({super.key});

  @override
  RecordsListPageState createState() => RecordsListPageState();
}

class RecordsListPageState extends State<RecordsListPage> with SingleTickerProviderStateMixin {
  late Future<List<FitRecord>> _recordsFuture;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _recordsFuture = RecordsViewmodel().fetchUserRecords();
    _tabController = TabController(length: 2, vsync: this); 
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Liste des Records'),
              Tab(text: 'Container Bleu'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                RecordsList(recordsFuture: _recordsFuture),
                const ExercisesRecordsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
